import re, json, bcrypt, jwt

from django.db.models import Q, Case, When
from django.views     import View
from django.http      import JsonResponse

from my_settings      import SECRET_KEY, ALGORITHM
from user.utils       import login_decorator
from user.models      import User, Follow, Like, PostBookmark, ProductBookmark, CollectionBookmark
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
    def post(self, request, user_id):
        try:
            user = User.objects.get(id=request.user.id)

            if user.id == user_id:
                return JsonResponse({'message':'DUPLICATE_ID'}, status=400)

            if Follow.objects.filter(follower_id=user.id, followee_id=user_id).exists():
                return JsonResponse({'message':'INVALID_FOLLOW'}, status=400)

            Follow.objects.create(follower_id=user.id, followee_id=user_id)

            return JsonResponse({'message':'SUCCESS'}, status=200)

        except KeyError:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)


class UnFollowView(View):
    @login_decorator
    def post(self, request, user_id):
        try:
            user          = User.objects.get(id=request.user.id)
            follow_status = Follow.objects.filter(follower_id=user.id, followee_id=user_id)

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

            # 게시물 
            if data.get('post_id'):
                # 해당 게시물이 북마크 되어 있는지 확인
                if PostBookmark.objects.filter(user_id=request.user.id, post_id=data['post_id']).exists():
                    return JsonResponse({'message': 'INVALID_BOOKMARK', 'error_messsage':'이 게시물은 현재  북마크 되어 있는 게시물입니다.'}, status=400)
                # 게시물 북마크
                PostBookmark.objects.create(user_id=request.user.id, post_id=data['post_id'])
                return JsonResponse({'message':'SUCCESS'}, status=200)

            # 상품 
            if data.get('product_id'):
                # 해당 상품이 북마크 되어 있는지 확인
                if ProductBookmark.objects.filter(user_id=request.user.id, product_id=data['product_id']).exists():
                    return JsonResponse({'messgae':'INVALID_BOOKMARK', 'error_message':'이 상품은 현재 북마크 되어 있는 상품입니다.'}, status=400)
                # 상품 북마크
                ProductBookmark.objects.create(user_id=request.user.id, product_id=data['product_id'])
                return JsonResponse({'message':'SUCCESS'}, status=200)

            # 콜렉션 
            # 해당 콜렉션이 북마크 되어 있는지 확인
            if CollectionBookmark.objects.filter(user_id=request.user.id, collection_id=data['collection_id']).exists():
                return JsonResponse({'message':'INVALID_BOOKMARK', 'error_message': '이 콜렉션은 현재 북마크 되어 있는 콜렉션입니다.'}, status=400)
            # 콜렉션 북마크
            CollectionBookmark.objects.create(user_id=request.user.id, collection_id=data['collection_id'])
            return JsonResponse({'message':'SUCCESS'}, status=200)

        except KeyError:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)


class UnBookmarkView(View):
     @login_decorator
     def post(self, request):
         try:
             data = json.loads(request.body)

             # 게시물
             if data.get('post_id'):
                 # 게시물 북마크 삭제
                 post_bookmark = PostBookmark.objects.get(user_id=request.user.id, post_id=data['post_id'])
                 post_bookmark.delete()
                 return JsonResponse({'message':'SUCCESS'}, status=200)

             # 상품
             if data.get('product_id'):
                 product_bookmark =  ProductBookmark.objects.get(user_id=request.user.id, product_id=data['product_id'])
                 product_bookmark.delete()
                 return JsonResponse({'message':'SUCCESS'}, status=200)

             # 콜렉션
             collection_bookmark = CollectionBookmark.objects.filter(user_id=request.user.id, collection_id=data['collection_id'])
             collection_bookmark.delete()
             return JsonResponse({'message':'SUCCESS'}, status=200)

         except DoesNotExist.PostBookmark:
             return JsonResponse({'messsage':'INVALID_UNBOOKMARK'}, status=400)
         except DoesNotExist.ProductBookmark:
             return JsonResponse({'messsage':'INVALID_UNBOOKMARK'}, status=400)
         except DoesNotExist.CollectionBookmark:
             return JsonResponse({'messsage':'INVALID_UNBOOKMARK'}, status=400)
         except KeyError:
             return JsonResponse({'message':'KEY_ERROR'}, status=400)


class MyPageView(View):
    @login_decorator
    def get(self, request, user_id):
        try:
            user                 = User.objects.get(id=user_id)
            posts                = Post.objects.select_related('author').prefetch_related('postbookmark_set', 'postimage_set', 'like_set')
            bookmark_posts       = PostBookmark.objects.select_related('post').filter(user_id=user.id).order_by('-id')
            bookmark_products    = ProductBookmark.objects.select_related('product').filter(user_id=user.id).order_by('-id')
            bookmark_collections = CollectionBookmark.objects.select_related('collection').filter(user_id=user.id).order_by('-id')

            context  = {
                'username'      : user.username,
                'user_image'    : user.profile_image_url,
                'follower'      : Follow.objects.filter(followee_id=user.id).count(),
                'following'     : Follow.objects.filter(follower_id=user.id).count(),
                'bookmark_count': bookmark_posts.count() + bookmark_products.count() + bookmark_collections.count(), 
                'like_count'    : Like.objects.filter(user_id=request.user.id).count(),
                'bookmark_posts': [
                    {
                        'post_id'  : bookmark_post.post_id,
                        'image_url': Post.objects.get(id=bookmark_post.post_id).postimage_set.first().image_url
                    }
                        for bookmark_post in bookmark_posts if bookmark_posts
                ],
                'bookmark_products': [
                    {
                        'product_id': bookmark_product.product_id,
                        'image_url' : Product.objects.get(id=bookmark_product.product_id).productimage_set.first().product_image_url
                    }
                        for bookmark_product in bookmark_products if bookmark_products
                ],
                'bookmark_collections': [
                    {
                        'collection_id': bookmark_collection.collection_id,
                        'image_url'    : Product.objects.filter(collection_id=bookmark_collection.collection_id).first().productimage_set.first().product_image_url
                    }
                        for bookmark_collection in bookmark_collections if bookmark_collections
                ],
                'like'                : [
                    {
                        'post_id'  : post.id,
                        'image_url': post.postimage_set.first().image_url
                    }
                        for post in posts if Like.objects.filter(user_id=user.id, post_id=post.id)
                ]
            }

            return JsonResponse({'context': context}, status=200)

        except User.DoesNotExist:
            return JsonResponse({'message': 'DOES_NOT_EXIST', 'error_message': '해당 사용자는 존재하지 않습니다.'})
        except KeyError:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)
