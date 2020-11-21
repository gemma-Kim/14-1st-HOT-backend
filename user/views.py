import re, json, bcrypt, jwt

from django.db.models import Q
from django.views     import View
from django.http      import JsonResponse

from my_settings      import SECRET_KEY, ALGORITHM
from user.models      import User, Follow, Like
from post.models      import Post
from user.utils       import login_decorator


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

            if type(data['id']) == str:
                return JsonResponse({'message':'TYPE_ERROR'}, status=400)

            if user.id == data['id']:
                return JsonResponse({'message':'DUPLICATION_ID'}, status=400)

            if Follow.objects.filter(follower_id=user.id, followee_id=data['id']).exists():
                return JsonResponse({'message':'INVALID_FOLLOW'}, status=400)

            Follow.objects.create(follower_id=user.id, followee_id=data['id'])

            return JsonResponse({'message':'SUCCESS'}, status=200)

        except KeyError:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)

    @login_decorator
    def delete(self, request):
        try:
            data          = json.loads(request.body)
            user          = User.objects.get(id=request.user.id)
            follow_status = Follow.objects.filter(follower_id=user.id, followee_id=data['id'])

            if not follow_status.exists():
                return JsonResponse({'messsage':'INVALID_UNFOLLOW'}, status=400)

            follow_status.delete()

            return JsonResponse({'message':'DELETED'}, status=200)

        except KeyError:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)

    @login_decorator
    def get(self, request):
        user      = User.objects.get(id=request.user.id)
        follower  = Follow.objects.filter(followee_id=user.id).count()
        following = Follow.objects.filter(follower_id=user.id).count()

        return JsonResponse({'follower':follower, 'following':following}, status=200)


class LikeView(View):
    @login_decorator
    def post(self, request):
        try:
            data = json.loads(request.body)
            user = User.objects.get(id=request.user.id)

            if Like.objects.filter(user_id=user.id, post_id=data['id']).exists():
                return JsonResponse({'message':'INVALID_LIKE'}, status=400)

            Like.objects.create(user_id=user.id, post_id=data['id'])

            return JsonResponse({'message':'SUCCESS'}, status=200)

        except KeyError:
            return JsonResponse({'message':"KEY_ERROR"}, status=400)

    @login_decorator
    def delete(self, request):
        try:
            data = json.loads(request.body)
            user = User.objects.get(id=request.user.id)

            if not Like.objects.filter(user_id=user.id, post_id=data['id']).exists():
                return JsonResponse({'message':'INVALID_DELETE'}, status=400)

            Like.objects.filter(user_id=user.id, post_id=data['id']).delete()

            return JsonResponse({'message':'SUCCESS'}, status=200)

        except KeyError:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)


    @login_decorator
    def get(self, request):
        posts = Post.objects.select_related('author').prefetch_related('postimage_set','like_set')

        context = [
            {
                'post_id'    : post.id,
                'author'     : post.author.username,
                'post_image' : post.postimage_set.all()[0].image_url,
                'like'       : post.like_set.count()
            }
            for post in posts
        ]

        return JsonResponse({'result': context}, status=200)
