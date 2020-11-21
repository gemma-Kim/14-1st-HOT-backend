from django.urls import path
from .views      import RegisterView, LogInView, FollowView


urlpatterns = [
    path('/register', RegisterView.as_view()),
    path('/login', LogInView.as_view()),
    path('/follow', FollowView.as_view())
]
