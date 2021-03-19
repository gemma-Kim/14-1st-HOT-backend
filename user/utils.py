import re, json, bcrypt, jwt

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

        except jwt.exceptions.DecodeError:
            return JsonResponse({'message':'INVALID_TOKEN'}, status=403)

        except User.DoesNotExist:
            return JsonResponse({'message':'INVALID_USER'}, status=401)

    return wrapper

def validator(value): 
    try:
        # email validation
        validation = re.compile(r'^[a-zA-Z0-9+-_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$')
        if not re.match(validation, value['email']):
            raise Exception('올바른 메일 형식이 아닙니다.')
        # password validation
        if len(value['password']) < 8:
            raise Exception('비밀번호는 8자리 이상이어야 합니다.')
        return value
    except Exception as e:
        print('예외가 발생했습니다.', e)


def check_password(self, value):
        try:
            user = User.objects.get(email=value['email'])
            if bcrypt.checkpw(value['password'].encode('utf-8'), user.password.encode('utf-8')):
                raise Exception('잘못된 비밀번호 입니다.')
            return value
        except Exception as e:
            print('예외가 발생했습니다.', e)
        except User.DoesNotExist:
            return Response(data='UNKNOWN_USER', status=400)

def hash_password(value):
    return bcrypt.hashpw(value.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')

def email_isvalid(value):
    try:
        validation = re.compile(r'^[a-zA-Z0-9+-_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$')
        if not re.match(validation, value):
            raise Exception('올바른 메일 형식이 아닙니다.')
        return value
    except Exception as e:
        print('예외가 발생했습니다.', e)

def password_isvalid(value):
    try:
        if value:
            if len(value) >= 8:
                return value
        raise Exception()
    except Exception as e:
        print('예외가 발생했습니다.')

def username_isvalid(value):
    try:
        if len(value) > 1:
            return value
        raise Exception('닉네임은 2 자리 이상이어야 합니다.')
    except Exception as e:
        print('예외가 발생했습니다.', e)
