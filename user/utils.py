import json, bcrypt, jwt

from django.http import JsonResponse

from user.models import User
from my_settings import SECRET_KEY, ALGORITHM


def login_decorator(func):
    def wrapper(self, request, *args, **kwargs):
        try:
            auth_token   = request.headers.get('Authorization', None)
            payload      = jwt.decode(auth_token, SECRET_KEY, algorithm = ALGORITHM)
            user         = User.objects.get(id=payload['id'])
            request.user = user

            return func(self, request, *args, **kwargs)

        except jwt.DecodeError:
            return JsonResponse({'message':'UNVALID_TOKEN'}, status=403)

        except User.DoesNotExist:
            return JsonResponse({'message':'UNVALID_USER'}, status=401)

    return wrapper
