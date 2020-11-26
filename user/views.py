import re, json, bcrypt, jwt

from django.db.models import Q
from django.views     import View
from django.http      import JsonResponse

from my_settings      import SECRET_KEY, ALGORITHM
from user.models      import User, Follow, Like, PostBookmark, ProductBookmark, CollectionBookmark
from user.utils       import login_decorator
from product.models   import Product
from post.models      import Post

class RegisterView(View):
    def post(self, request):
        try:
            data = json.loads(request.body)

            email     = data['email']
            username  = data['username']
            password  = data['password']

            email_validation = re.compile(r'^[a-zA-Z0-9+-_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$')

            if not re.match(email_validation, email):
                return JsonResponse({'message':'INVALID_EMAIL'}, status=400)

            if User.objects.filter(Q(email=email) | Q(username=username)).exists():
                return JsonResponse({'message':'EXIST_USER'}, status=400)

            hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')

            User.objects.create(
                username = username,
                email    = email,
                password = hashed_password
            )

            return JsonResponse({'message':'SUCCESS'}, status=200)

        except KeyError:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)


class LogInView(View):
    def post(self, request):
        try:
            signin_data      = json.loads(request.body)
            user             = User.objects.get(email=signin_data['email'])
            email            = signin_data['email']
            password         = signin_data['password']
            email_validation = re.compile(r'^[a-zA-Z0-9+-_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$')

            if not re.match(email_validation, email):
                return JsonResponse({'message':'INVALID_EMAIL'}, status=400)

            if not bcrypt.checkpw(password.encode('utf-8'), user.password.encode('utf-8')):
                return JsonResponse({'message':'WRONG_PASSWORD'}, status=400)

            access_token = jwt.encode({'id':user.id}, SECRET_KEY, algorithm = ALGORITHM).decode('utf-8')

            return JsonResponse({'message':'SUCCESS', 'access_token':access_token}, status=200)

        except User.DoesNotExist:
            return JsonResponse({'message':'UNKNOWN_USER'}, status=400)

        except KeyError:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)


class FollowView(View):
    @login_decorator
    def post(self, request):
        try:
            data = json.loads(request.body)
            user = User.objects.get(id=request.user.id)

            if type(data['id']) != int:
                return JsonResponse({'message':'TYPE_ERROR'}, status=400)

            if user.id == data['id']:
                return JsonResponse({'message':'DUPLICATE_ID'}, status=400)

            if Follow.objects.filter(follower_id=user.id, followee_id=data['id']).exists():
                return JsonResponse({'message':'INVALID_FOLLOW'}, status=400)

            Follow.objects.create(follower_id=user.id, followee_id=data['id'])

            return JsonResponse({'message':'SUCCESS'}, status=200)

        except KeyError:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)

class UnFollowView(View):
    @login_decorator
    def post(self, request):
        try:
            data          = json.loads(request.body)
            user          = User.objects.get(id=request.user.id)
            follow_status = Follow.objects.filter(follower_id=user.id, followee_id=data['id'])

            if not follow_status.exists():
                return JsonResponse({'messsage':'INVALID_UNFOLLOW'}, status=400)

            follow_status.delete()

            return JsonResponse({'message':'DELETED'}, status=200)

        except KeyError:
            return JsonResponse({'message': "KEY_ERROR"}, status=200)


class BookmarkView(View):
    @login_decorator
    def post(self, request):
        try:
            data = json.loads(request.body)

            if 'post_id' in data:
                if PostBookmark.objects.filter(user_id=request.user.id, post_id=data['post_id']).exists():
                    return JsonResponse({'messsage':'INVALID_BOOKMARK'}, status=400)

                PostBookmark.objects.create(user_id=request.user.id, post_id=data['post_id'])

                return JsonResponse({'message':'SUCCESS'}, status=200)

            if 'product_id' in data:
                if ProductBookmark.objects.filter(user_id=request.user.id, product_id=data['product_id']).exists():
                    return JsonResponse({'messgae':'INVALID_BOOKMARK'}, status=400)

                ProductBookmark.objects.create(user_id=request.user.id, product_id=data['product_id'])

                return JsonResponse({'message':'SUCCESS'}, status=200)

            if CollectionBookmark.objects.filter(user_id=request.user.id, collection_id=data['collection_id']).exists():
                return JsonResponse({'message':'INVALID_BOOKMARK'}, status=400)
 
            CollectionBookmark.objects.create(user_id=request.user.id, collection_id=data['collection_id'])

            return JsonResponse({'message':'SUCCESS'}, status=200)

        except KeyError:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)


class UnBookmarkView(View):
     @login_decorator
     def post(self, request):
         try:
             data = json.loads(request.body)

             if 'post_id' in data:
                 if not PostBookmark.objects.filter(user_id=request.user.id, post_id=data['post_id']).exists():
                     return JsonResponse({'messsage':'INVALID_DELETE'}, status=400)

                 PostBookmark.objects.filter(user_id=request.user.id, post_id=data['post_id']).delete()

                 return JsonResponse({'message':'SUCCESS'}, status=200)

             if 'product_id' in data:
                 if not ProductBookmark.objects.filter(user_id=request.user.id, product_id=data['product_id']).exists():
                     return JsonResponse({'messgae':'INVALID_BOOKMARK'}, status=400)

                 ProductBookmark.objects.filter(user_id=request.user.id, product_id=data['product_id']).delete()

                 return JsonResponse({'message':'SUCCESS'}, status=200)

             if not CollectionBookmark.objects.filter(user_id=request.user.id, collection_id=data['collection_id']).exists():
                 return JsonResponse({'message':'INVALID_BOOKMARK'}, status=400)

             CollectionBookmark.objects.filter(user_id=request.user.id, collection_id=data['collection_id']).delete()

             return JsonResponse({'message':'SUCCESS'}, status=200)

         except KeyError:
             return JsonResponse({'message':'KEY_ERROR'}, status=400)


class LikeView(View):
    @login_decorator
    def post(self, request):
        try:
            data = json.loads(request.body)

            if Like.objects.filter(user_id=request.user.id, post_id=data['post_id']).exists():
                return JsonResponse({'message':'INVALID_LIKE'}, status=400)

            Like.objects.create(user_id=request.user.id, post_id=data['post_id'])

            return JsonResponse({'message':'SUCCESS'}, status=200)

        except KeyError:
            return JsonResponse({'message':"KEY_ERROR"}, status=400)


class UnLikeView(View):
    def post(self, request):
        try:
            data = json.loads(request.body)

            if not Like.objects.filter(user_id=request.user.id, post_id=data['post_id']).exists():

                return JsonResponse({'message':'INVALID_DELETE'}, status=400)

            Like.objects.filter(user_id=user.id, post_id=data['post_id']).delete()

            return JsonResponse({'message':'SUCCESS'}, status=200)

        except KeyError:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)


class MyPageView(View):
    @login_decorator
    def get(self, request):
        try:
            user                 = User.objects.get(id=request.user.id)
            posts                = Post.objects.select_related('author').prefetch_related('postbookmark_set', 'postimage_set', 'like_set')
            bookmark_posts       = PostBookmark.objects.select_related('post').filter(user_id=user.id).order_by('-id')
            bookmark_products    = ProductBookmark.objects.select_related('product').filter(user_id=user.id).order_by('-id')
            bookmark_collections = CollectionBookmark.objects.select_related('collection').filter(user_id=user.id).order_by('-id')

            context  = {
                'username'            : user.username,
                'user_image'          : user.profile_image_url,
                'follower'            : Follow.objects.filter(followee_id=user.id).count(),
                'following'           : Follow.objects.filter(follower_id=user.id).count(),
                'bookmark_count'      : bookmark_posts.count() + bookmark_products.count() + bookmark_collections.count(), 
                'like_count'          : Like.objects.filter(user_id=user.id).count(),

                'bookmark_posts'      : [
                    {
                        'post_id'  : bookmark_post.post_id,
                        'image_url': Post.objects.get(id=bookmark_post.post_id).postimage_set.first().image_url
                    }
                        for bookmark_post in bookmark_posts if bookmark_posts
                ],

                'bookmark_products'   : [
                    {
                        'product_id': bookmark_product.product_id,
                        'image_url' : Product.objects.get(id=bookmark_product.product_id).productimage_set.first().product_image_url
                    }
                        for bookmark_product in bookmark_products if bookmark_products
                ],

                'bookmark_collections' : [
                    {
                        'collection_id': bookmark_collection.collection_id,
                        'image_url'    : Product.objects.filter(collection_id=bookmark_collection.collection_id).first().productimage_set.first().product_image_url
                    }
                        for bookmark_collection in bookmark_collections if bookmark_collections
                ],

                'like'                 : [
                    {
                        'post_id'  : post.id,
                        'image_url': post.postimage_set.first().image_url
                    }
                        for post in posts if Like.objects.filter(user_id=user.id, post_id=post.id)
                ]
            }

            return JsonResponse({'context': context}, status=200)

        except KeyError:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)
