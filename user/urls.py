from django.urls import path
from .views      import RegisterView, SignInView, LikeView, BookmarkView, UnBookmarkView


urlpatterns = [
    path('/register', RegisterView.as_view()),
    path('/signin', SignInView.as_view()),
    #path('/follow', FollowView.as_view()),
    path('/like', LikeView.as_view()),
    path('/bookmark', BookmarkView.as_view()),
    path('/unbookmark', UnBookmarkView.as_view())
]
