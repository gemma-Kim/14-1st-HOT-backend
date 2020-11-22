from django.urls import path
from .views      import RegisterView, SignInView, FollowView, LikeView


urlpatterns = [
    path('/register', RegisterView.as_view()),
    path('/signin', SignInView.as_view()),
    path('/follow', FollowView.as_view()),
    path('/like', LikeView.as_view()
]
