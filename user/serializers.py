import re, bcrypt, jwt

from django.core.exceptions import ValidationError
from django.http      import JsonResponse

from rest_framework import serializers
from rest_framework.response import Response
from rest_framework.validators import UniqueTogetherValidator

from .models import User
from .utils import (email_isvalid, 
    password_isvalid, 
    username_isvalid,
    hash_password,
)

class UserSerializer(serializers.ModelSerializer):
    user_id = serializers.SerializerMethodField()

    class Meta:
        model = User
        fields = ['user_id', 'email', 'username', 'password', 'profile_image_url']
        extra_kwargs = {
            'password': {'write_only': True},
        }
        validators = [
            UniqueTogetherValidator(
                queryset=User.objects.all(),
                fields=('email', 'username')
            ),
        ]

    def validate_email(self, obj):
        if email_isvalid(obj):
            return obj
        raise serializers.ValidationError('메일 형식이 올바르지 않습니다.')

    def validate_password(self, obj):
        if password_isvalid(obj):
            return hash_password(obj)
        raise serializers.ValidationError("비밀번호는 8 자리 이상이어야 합니다.")

    def validate_username(self, obj):
        if username_isvalid(obj):
            return obj
        raise serializers.ValidationError('닉네임은 한 글자 이상이어야 합니다.')

    def get_user_id(self, obj):
        return obj.id

    def update(self, obj, validated_data):
        obj.email = validated_data.get('email', obj.email)
        obj.username = validated_data.get('username', obj.username)
        obj.password = hash_password(validated_data.get('password', obj.password))
        obj.profile_image_url = validated_data.get('profile_image_url', obj.profile_image_url)
        obj.save()
        return obj
    
        
            
class LoginSerializer(serializers.Serializer):
    email = serializers.EmailField()
    password = serializers.CharField(max_length=100)
    user_id = serializers.SerializerMethodField()
    access_token = serializers.SerializerMethodField()

    class Meta:
        fields = ('user_id', 'email', 'password', 'access_token')

    def check_password(self, obj):
        try:
            user = User.objects.get(email=obj.email)
            if bcrypt.checkpw(obj.password.encode('utf-8'), user.password.encode('utf-8')):
                raise Exception('잘못된 비밀번호 입니다.')
            return obj
        except Exception as e:
            print('예외가 발생했습니다.', e)
        except User.DoesNotExist:
            return Response(data='UNKNOWN_USER', status=400)

    def get_user_id(self, obj):
        try:
            print('와우')
            return User.objects.get(email=obj['email']).id
        except:
            raise serializers.ValidationError('사용자가 존재하지 않습니다.')

    def get_access_token(self, obj):
        # token 발급기 추가하기
        return jwt.encode({'id': obj['user_id']}, SECRET_KEY, algorithm = ALGORITHM).decode('utf-8')
    
    def create(self, validated_data):

        validated_data.pop('email')
        validated_data.pop('password')
        print('****')
        return super().create(**validated_data)
