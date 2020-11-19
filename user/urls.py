from django.urls import path
from .views      import Register, SignIn, Follow


urlpatterns = [
    path('/register', Register.as_view()),
    path('/signin', SignIn.as_view()),
]
