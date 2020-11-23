import json

from django.http      import JsonResponse
from django.views     import View
from django.db.models import Q

from post.models import Post, PostImage, ProductInPost, Comment, Tag, PostTag
from user.models import User

class PostDetailView(View):
    def get(self, request, post_id):
        try:
            post = Post.objects.\
                    prefetch_related(
                        'posttag_set',
                        'posttag_set__tag',
                        'postimage_set',
                        'comment_set',
                        'comment_set__author',
                        'like_set',
                        'like_set__user',
                        'postbookmark_set',
                        'postbookmark_set__user'
                    ).select_related('author').get(id=post_id)

            result = {
                        'post_id'         : post.id,
                        'content'         : post.content,
                        'created_at'      : post.created_at,
                        'updated_at'      : post.updated_at,
                        'likes_count'     : post.like_set.count(),
                        'bookmarks_count' : post.postbookmark_set.count(),
                        'comments_count'  : post.comment_set.count(),
                        'likes_detail'    : [
                            {
                                'user_id'  : like.user.id,
                                'username' : like.user.username
                            }
                            for like in post.like_set.all()
                        ],
                        'bookmarks_detail' : [
                            {
                                'user_id'  : bookmark.user.id,
                                'username' : bookmark.user.username
                            }
                            for bookmark in post.postbookmark_set.all()
                        ],
                        'author' : {
                            'author_id'     : post.author.id,
                            'username'      : post.author.username,
                            'profile_image' : post.author.profile_image_url
                        },
                        'tags'     : [ tag.tag.name for tag in post.posttag_set.all() ],
                        'comments' : [
                            {
                                'id': comment.id,
                                'author': {
                                    'author_id'     : comment.author.id,
                                    'username'      : comment.author.username,
                                    'profile_image' : comment.author.profile_image_url
                                },
                                'content'    : comment.content,
                                'created_at' : comment.created_at,
                                'updated_at' : comment.updated_at,
                                'parent_id'  : comment.parent_id,
                            }
                            for comment in post.comment_set.all()
                        ],
                        'post_images' : [
                            {
                                'image_url' : postimage.image_url
                            }
                            for postimage in post.postimage_set.all()
                        ]
            }

            return JsonResponse({'results' : result}, status = 200)

        except Post.DoesNotExist:
            return JsonResponse({'message': 'INVALID_POST'}, status = 400)
