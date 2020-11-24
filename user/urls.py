from django.urls import path
from .views      import RegisterView, LogInView, LikeView, BookmarkView, UnBookmarkView


urlpatterns = [
    path('/register', RegisterView.as_view()),
    path('/login', LogInView.as_view()),
    #path('/follow', FollowView.as_view()),
    path('/like', LikeView.as_view()),
    path('/bookmark', BookmarkView.as_view()),
    path('/unbookmark', UnBookmarkView.as_view())
]
