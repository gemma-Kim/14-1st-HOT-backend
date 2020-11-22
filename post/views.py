import json

from django.http      import JsonResponse
from django.views     import View
from django.db.models import Q

from post.models import Post, PostImage, ProductInPost, Comment, Tag, PostTag
from user.models import User, Like, PostBookmark

class PostView(View):
    def get(self, request):
        posts = Post.objects.prefetch_related(
            'like_set',
            'like_set__user',
            'postbookmark_set',
            'postbookmark_set__user',
            'comment_set',
            'comment_set__author',
            'postimage_set',
        ).select_related('author').all()

        results = [
            {
                'post_id'              : post.id,
                'post_content'         : post.content,
                'post_author_id'       : post.author.id,
                'post_author_username' : post.author.username,
                'post_author_profile'  : post.author.profile_image_url,
                'post_mainimage_url'   : post.postimage_set.all()[0].image_url,
                'post_likes_count'     : post.like_set.count(),
                'post_bookmarks_count' : post.postbookmark_set.count(),
                'post_comments_count'  : post.comment_set.count(),
                'likes_detail' : [
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
                'comment' : [
                    {
                        'author_id'       : comment.author.id,
                        'author_username' : comment.author.username,
                        'author_profile'  : comment.author.profile_image_url,
                        'content'         : comment.content,
                    }
                    for comment in post.comment_set.all()
                ],
            }
            for post in posts
        ]

        return JsonResponse({'result' : results}, status = 200)
