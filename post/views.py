import json

from django.http      import JsonResponse
from django.views     import View
from django.db.models import Q

from post.models import Post, PostImage, ProductInPost, Comment, Tag, PostTag
from user.models import User, Like, PostBookmark
from user.utils  import login_decorator

class PostView(View):
    @login_decorator
    def post(self, request):
        data = json.loads(request.body)
        user = request.user

        if not 'content' in data or not 'images' in data or not 'tags' in data:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)

        try:
            if not data['images']:
                return JsonResponse({'message':'IMAGE_PLZ'}, status=400)

            image_list = [image_url for image_url in data['images']]

        except TypeError:
            return JsonResponse({'message':'IMAGES_TYPE_ERROR'}, status=400)

        if data['tags']:
            try:
                tags_list = [tag for tag in data['tags']]

            except TypeError:
                return JsonResponse({'message':'TAGS_TYPE_ERROR'}, status=400)

        created_post = Post.objects.create(
            content = data['content'],
            author  = user
        )

        for image in image_list:
            PostImage.objects.create(
                post      = created_post,
                image_url = image
            )

        if data['tags']:
            for tag in tag_list:
                if not tag or tag.isspace():
                    return JsonResponse({'message':'CHECK TAG VALUE'}, status=400)

                created_tag = Tag.objects.create(name = tag)
                PostTag.objects.create(
                    tag  = created_tag,
                    post = created_post
                )

            except TypeError:
                return JsonResponse({'message':'TAGS_TYPE_ERROR'}, status=400)

        return JsonResponse({'message':'SUCCESS'}, status=201)


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
