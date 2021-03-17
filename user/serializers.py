import re, bcrypt

from django.core.exceptions import ValidationError

from rest_framework import serializers
from rest_framework.validators import UniqueTogetherValidator

from user.models import User

class RegisterSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = '__all__'
        validators = [
            UniqueTogetherValidator(
                queryset=User.objects.all(),
                fields=('email', 'username')
            ),
        ]

    def validate(self, value): 
        try:
            # email validation
            email_validation = re.compile(r'^[a-zA-Z0-9+-_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$')
            if not re.match(email_validation, value['email']):
                raise Exception('올바른 메일 형식이 아닙니다.')
            # password validation
            if len(value['password']) < 8:
                raise Exception('비밀번호는 8자리 이상이어야 합니다.')
            # hashed password
            value['password'] = bcrypt.hashpw(value['password'].encode('utf-8'), bcrypt.gensalt()).decode('utf-8')
            return value
        except Exception as e:
            print('예외가 발생했습니다.', e)
