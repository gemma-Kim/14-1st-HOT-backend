import re, json, bcrypt, jwt

from django.db        import transaction
from django.db.models import Q
from django.views     import View
from django.http      import JsonResponse

from my_settings      import SECRET_KEY, ALGORITHM
from user.utils       import login_decorator
from user.models      import User, Follow, Like, PostBookmark, ProductBookmark, CollectionBookmark
from product.models   import Product
from post.models      import Post, PostImage


class RegisterView(View):
    @transaction.atomic
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
    @transaction.atomic
    def post(self, request):
        try:
            data             = json.loads(request.body)
            user             = User.objects.get(email=data.get('email'))
            email            = data.get('email', "")
            password         = data.get('password', "")
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
    @transaction.atomic
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

        except User.DoesNotExist:
            return JsonResponse({'message': 'DOES_NOT_EXIST', 'error_message': '해당 사용자는 존재하지 않습니다.'})
        except KeyError:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)


class UnFollowView(View):
    @transaction.atomic
    @login_decorator
    def post(self, request, user_id):
        try:
            user          = User.objects.get(id=request.user.id)
            follow_status = Follow.objects.filter(follower_id=user.id, followee_id=user_id)

            if not follow_status.exists():
                return JsonResponse({'messsage':'INVALID_UNFOLLOW'}, status=400)

            follow_status.delete()

            return JsonResponse({'message':'DELETED'}, status=200)

        except User.DoesNotExist:
            return JsonResponse({'message': 'DOES_NOT_EXIST', 'error_message': '해당 사용자는 존재하지 않습니다.'})
        except KeyError:
            return JsonResponse({'message': "KEY_ERROR"}, status=200)


class BookmarkView(View):
    @transaction.atomic
    @login_decorator
    def post(self, request):
        try:
            data       = json.loads(request.body)
            post       = data.get('post_id')
            product    = data.get('product_id')
            collection = data.get('collection_id')

            # 게시물, 상물, 콜렉션이 모두 없는 경우
            if not (post or product or collection):
                return JsonResponse({'message':'INVALID_BOOKMARK', 'error_message':'북마크 컨텐츠가 없습니다.'}, status=400)

            # 게시물
            if post:
                # 해당 게시물이 북마크 되어 있는지 확인
                if PostBookmark.objects.filter(user_id=request.user.id, post_id=post).exists():
                    return JsonResponse({'message':'INVALID_BOOKMARK', 'error_messsage':'이 게시물은 현재  북마크 되어 있는 게시물입니다.'}, status=400)
                # 게시물 북마크
                with transaction.atomic():
                    PostBookmark.objects.create(user_id=request.user.id, post_id=post)
                    return JsonResponse({'message':'SUCCESS'}, status=200)

            # 상품 
            if product:
                # 해당 상품이 북마크 되어 있는지 확인
                if ProductBookmark.objects.filter(user_id=request.user.id, product_id=product).exists():
                    return JsonResponse({'messgae':'INVALID_BOOKMARK', 'error_message':'이 상품은 현재 북마크 되어 있는 상품입니다.'}, status=400)
                # 상품 북마크
                with transaction.atomic():
                    ProductBookmark.objects.create(user_id=request.user.id, product_id=product)
                    return JsonResponse({'message':'SUCCESS'}, status=200)

            # 콜렉션 
            # 해당 콜렉션이 북마크 되어 있는지 확인
            if CollectionBookmark.objects.filter(user_id=request.user.id, collection_id=collection).exists():
                return JsonResponse({'message':'INVALID_BOOKMARK', 'error_message': '이 콜렉션은 현재 북마크 되어 있는 콜렉션입니다.'}, status=400)
            # 콜렉션 북마크
            with transaction.atomic():
                CollectionBookmark.objects.create(user_id=request.user.id, collection_id=collection)
                return JsonResponse({'message':'SUCCESS'}, status=200)

        except KeyError:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)


class UnBookmarkView(View):
    @transaction.atomic
    @login_decorator
    def post(self, request):
        try:
            data = json.loads(request.body)
            post       = data.get('post_id')
            product    = data.get('product_id')
            collection = data.get('collection_id')

            # 게시물, 상품, 콜렉션이 없는 경우
            if not (post or product or collection):
                return JsonResponse({'message':'INVALID_UNBOOKMARK', 'error_message':'북마크 취소 컨텐츠가 없습니다.'}, status=400)

            # 게시물
            if post:
                post_bookmark = PostBookmark.objects.get(user_id=request.user.id, post_id=post)
                post_bookmark.delete()
                return JsonResponse({'message':'SUCCESS'}, status=200)

             # 상품
            if product:
                product_bookmark = ProductBookmark.objects.get(user_id=request.user.id, product_id=product)
                product_bookmark.delete()
                return JsonResponse({'message':'SUCCESS'}, status=200)

            # 콜렉션
            collection_bookmark = CollectionBookmark.objects.filter(user_id=request.user.id, collection_id=collection)
            collection_bookmark.delete()
            return JsonResponse({'message':'SUCCESS'}, status=200)

        except DoesNotExist.PostBookmark:
            return JsonResponse({'messsage':'INVALID_UNBOOKMARK', 'error_message':'북마크 취소할 게시물이 없습니다.'}, status=400)
        except DoesNotExist.ProductBookmark:
            return JsonResponse({'messsage':'INVALID_UNBOOKMARK', 'error_message':'북마크 취소할 상품이 없습니다.'}, status=400)
        except DoesNotExist.CollectionBookmark:
            return JsonResponse({'messsage':'INVALID_UNBOOKMARK', 'error_message':'북마크 취소할 콜렉션이 없습니다.'}, status=400)
        except KeyError:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)


class MyPageView(View):
    @login_decorator
    def get(self, request):
        try:
            user                 = User.objects.get(id=request.user.id)
            followers            = Follow.objects.filter(followee_id=user.id)
            followings           = Follow.objects.filter(follower_id=user.id)
            likes                = Like.objects.filter(user_id=request.user.id)

            bookmark_posts       = PostBookmark.objects\
                .select_related('post')\
                .prefetch_related('post__postimage_set')\
                .filter(user_id=user.id).order_by('-id')

            bookmark_products    = ProductBookmark.objects\
                .select_related('product')\
                .prefetch_related('product__productimage_set')\
                .filter(user_id=user.id).order_by('-id')

            bookmark_collections = CollectionBookmark.objects\
                .select_related('collection')\
                .prefetch_related('collection__product_set','collection__product_set__productimage_set')\
                .filter(user_id=user.id).order_by('-id')

            like_posts           = Like.objects\
                .select_related('post')\
                .prefetch_related('post__postimage_set')\
                .filter(user_id=user.id).order_by('-id')
            
            context = {
                'username'      : user.username,
                'user_image'    : user.profile_image_url,
                'follower'      : followers.count(),
                'following'     : followings.count(),
                'like_count'    : likes.count(),
                'bookmark_count': bookmark_posts.count() + bookmark_products.count() + bookmark_collections.count(), 
                'bookmark_posts': [
                    {
                        'post_id'  : bookmark_post.post.id,
                        'image_url': bookmark_post.post.postimage_set.first().image_url
                    }
                        for bookmark_post in bookmark_posts
                ],
                'bookmark_products': [
                    {
                        'product_id': bookmark_product.product.id,
                        'image_url' : bookmark_product.product.productimage_set.first().product_image_url
                    }
                        for bookmark_product in bookmark_products
                ],
                'bookmark_collections': [
                    {
                        'collection_id': bookmark_collection.collection.id,
                        'image_url'    : bookmark_collection.collection.product_set.first().productimage_set.first().product_image_url
                    }
                        for bookmark_collection in bookmark_collections if bookmark_collection.collection.product_set.first()
                ],
                'like': [
                    {
                        'post_id'  : like_post.post.id,
                        'image_url': like_post.post.postimage_set.first().image_url
                    }   
                        for like_post in like_posts if like_post.post
                ]
            }
            return JsonResponse({'context': context}, status=200)

        except User.DoesNotExist:
            return JsonResponse({'message': 'DOES_NOT_EXIST', 'error_message': '해당 사용자는 존재하지 않습니다.'})
        except KeyError:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)