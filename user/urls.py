from django.urls import path
from .views      import RegisterView, LogInView, FollowView, LikeView


urlpatterns = [
    path('/register', RegisterView.as_view()),
    path('/login', LogInView.as_view()),
    path('/follow', FollowView.as_view()),
    path('/like', LikeView.as_view())
]
