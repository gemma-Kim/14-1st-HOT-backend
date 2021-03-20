import re, bcrypt, jwt

from rest_framework import serializers
from rest_framework.response import Response
from rest_framework.validators import UniqueTogetherValidator
from rest_framework_simplejwt.tokens import RefreshToken

from .models import User
from .utils import (
    email_isvalid, 
    password_isvalid, 
    username_isvalid,
    hash_password,
    check_password,
)

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'email', 'username', 'password', 'profile_image_url']
        extra_kwargs = {
            'password': {'write_only': True},
        }
        validators = [
            UniqueTogetherValidator(
                queryset=User.objects.all(),
                fields=('email', 'username'),
                message="이미 존재하는 회원입니다."
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

    def update(self, obj, validated_data):
        obj.email = validated_data.get('email', obj.email)
        obj.username = validated_data.get('username', obj.username)
        obj.password = hash_password(validated_data.get('password', obj.password))
        obj.profile_image_url = validated_data.get('profile_image_url', obj.profile_image_url)
        obj.save()
        return obj
        
            
class LoginSerializer(serializers.ModelSerializer):
    access_token = serializers.SerializerMethodField()

    class Meta:
        model = User
        fields = ('id', 'email', 'password', 'access_token')
        write_only_fields = ['email', 'password']
    
    def validate_password(self, obj):
        email = self.initial_data['email']
        password = User.objects.get(email=email).password
        if check_password(obj, password):
            return password
        raise serializers.ValidationError('비밀번호가 올바르지 않습니다.')

    def get_access_token(self, obj):
        user = User.objects.get(id=obj.id)
        refresh = RefreshToken.for_user(user)
        return str(refresh.access_token)
        