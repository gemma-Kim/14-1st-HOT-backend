import json

from django.http      import JsonResponse
from django.views     import View
from django.db.models import Q, Prefetch
from django.db        import transaction

from post.models import Post, PostImage, ProductInPost, Comment, Tag, PostTag
from user.models import User, Like, PostBookmark
from user.utils  import login_decorator

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
        ).select_related('author').all().order_by('-id')

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
                'comments' : [
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


class PostDetailView(View):
    def listValidation(values):
    try:
        for value in values:
            if not value or value.isspace():
                return False
    except TypeError:
        return False

    return True

    def get(self, request, post_id):
        try:
            post = Post.objects.prefetch_related(
                'posttag_set',
                'posttag_set__tag',
                'postimage_set',
                'comment_set',
                'comment_set__author',
                'like_set',
                'like_set__user',
                'postbookmark_set',
                'postbookmark_set__user',
                'productinpost_set',
                'productinpost_set__product',
                'productinpost_set__product__productimage_set'
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
                        ],
                        'linked_products': [
                            {
                                'image_url'    : linkedproduct.product.productimage_set.first().product_image_url,
                                'product_id'   : linkedproduct.product_id,
                                'product_name' : linkedproduct.product.name,
                                'left'         : linkedproduct.left_position,
                                'top'          : linkedproduct.top_position
                            }
                            for linkedproduct in post.productinpost_set.all()
                        ]
            }

            return JsonResponse({'results' : result}, status = 200)

        except Post.DoesNotExist:
            return JsonResponse({'message': 'INVALID_POST'}, status = 400)


    @login_decorator
    def delete(self, request, post_id):
        try:
            user = request.user
            post = Post.objects.get(id=post_id)
        except Post.DoesNotExist:
            return JsonResponse({'message': 'INVALID_POST'}, status=400)

        if user.id != post.user_id:
            return JsonResponse({'message': 'INVALID_USER'}, status=403)

        post.delete()
        return JsonResponse({'message': 'SUCCESS'}, status=200)


    @transaction.atomic
    @login_decorator
    def put(self, request, post_id):
        user            = request.user
        data            = json.loads(request.body)
        linked_products = data.get('linked_products') #dictionary -option

        if not 'content' in data or not 'images' in data or not 'tags' in data:
            return JsonResponse({'message': 'KEY_ERROR'}, status=400)

        if not data['images']:
            return JsonResponse({'message': 'IMAGE_PLZ'}, status=400)

        try:
            post = Post.objects.get(id=post_id)

        except Post.DoesNotExist:
            return JsonResponse({'message': 'INVALID_POST'}, status=400)

        if post.author_id != user.id:
            return JsonResponse({'message': 'AUTHOR_DOES_NOT_MATCH'}, status=400)

        if data['images']:
            if not listValidation(data['images']:
                return JsonResponse({'message': 'IMAGE_VALUE_ERROR'}, status=400)

            for image in data['images']:
                try:
                    new_image = PostImage.objects.get(image_url=image, post=post)

                except Image.DoesNotExist:
                    new_image = PostImage.objects.create(image_url=image, post=post)

        if data['tags']:
            if not listValidation(tags):
                return JsonResponse({'message': 'TAG_VALUE_ERROR'}, status=400)

            for tag in data['tags']:
                try:
                    new_tag = Tag.objects.get(name=tag)

                except Tag.DoesNotExist:
                    new_tag = Tag.objects.create(name=tag)

                try:
                    PostTag.objects.get(tag=tag, post=post)

                except PostTag.DoesNotExist:
                    PostTag.objects.create(tag=new_tag, post=post)

        if linked_products:
            if not listValidation(linked_products):
                return JsonResponse({'message': 'PRODUCT_VALUE_ERROR'}, status=400)

            for linked_product_id in linked_products:
                try:
                    Product.objects.get(id=linked_product_id)
                except Product.DoesNotExist:
                    return JsonResponse({'message': 'INVALID_PRODUCT'}, status=400)

                try:
                    linked_check = ProductInPost.objects.get(post=post, product_id=linked_product_id)

                except ProductInPost.DoesNotExist:
                    ProductInPost.objects.create(post=post, product_id=linked_product_id)

        post.content = data['content']
        post.save()

        return JsonResponse({'message': 'SUCCESS'}, status=200)


class CommentView(View):
    def get(self, request, post_id):
        try:
            post = Post.objects.prefetch_related
            ('comment_set__author').get(id=post_id)

        except Post.DoesNotExist:
            return JsonResponse({'message': 'INVALID_POST'}, status=400)

        results = {
            'comments' : [
                {
                    'id': comment.id,
                    'author': {
                        'author_id' : comment.author.id,
                        'username' : comment.author.username,
                        'profile_image' : comment.author.profile_image_url
                    },
                    'content': comment.content,
                    'created_at': comment.created_at,
                    'updated_at': comment.updated_at,
                    'parent_id': comment.parent_id
                }
                for comment in post.comment_set.all()
            ]
        }

        return JsonResponse({'results': results}, status=200)


    @login_decorator
    def post(self, request, post_id):
        user      = request.user
        data      = json.loads(request.body)
        parent_id = data.get('parent')

        if not 'content' in data:
            return JsonResponse({'message': 'KEY_ERROR'}, status=400)

        if not data['content'] or data['content'].isspace():
            return JsonResponse({'message': 'CONTENT_NULL'}, status=400)

        try:
            post = Post.objects.get(id=post_id)

            Comment.objects.create(
                content = data['content'],
                post    = post,
                author  = user,
                parent_id = parent_id
            )
            comments = Comment.objects.select_related('author').filter(post=post)
            results = {
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
                                'parent_id'  : comment.parent_id
                            }
                            for comment in comments
                        ]
                    }

            return JsonResponse({'message': 'SUCCESS', 'results':results}, status=200)

        except Post.DoesNotExist:
            return JsonResponse({'message': 'INVALID_POST'}, status=400)


class CommentModifyView(View):
    @login_decorator
    def delete(self, request, post_id, comment_id):
        try:
            user = request.user
            comment = Comment.objects.get(id=comment_id)
        except Comment.DoesNotExist:
            return JsonResponse({'message': 'INVALID_COMMENT'}, status=400)

        if post_id != comment.post_id:
            return JsonResponse({'message': 'POST_ID_DOES_NOT_MATCH'}, status=400)

        if user.id != comment.author_id:
            return JsonResponse({'message': 'INVALID_USER'}, status=403)

        comment.delete()
        return JsonResponse({'message': 'SUCCESS'}, status=200)

    @login_decorator
    def patch(self, request, post_id, comment_id):
        data = json.loads(request.body)
        user = request.user

        try:
            comment = Comment.objects.get(id=comment_id)
        except Comment.DoesNotExist:
            return JsonResponse({'message': 'INVALID_COMMENT'}, status=400)

        if post_id != comment.post_id:
            return JsonResponse({'message': 'POST_DOES_NOT_MATCH'}, status=400)

        if user.id != comment.author_id:
            return JsonResponse({'message': 'INVALID_USER'}, status=403)

        if not 'content' in data:
            return JsonResponse({'message': 'KEY_ERROR'}, status=400)

        if not data['content'] or data['content'].isspace():
            return JsonResponse({'message': 'CONTENT_VALUE_ERROR'}, status=400)

        comment.content = data['content']
        comment.save()

        return JsonResponse({'message': 'SUCCESS'}, status=200)
