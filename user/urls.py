from django.urls import path
from .views      import Register, Login, FollowView, UnFollowView, BookmarkView, UnBookmarkView, MyPageView


urlpatterns = [
    path('/register', Register.as_view()),
    path('/login', Login.as_view()),
    path('/friendships/<int:user_id>/follow', FollowView.as_view()),
    path('/friendships/<int:user_id>/unfollow', UnFollowView.as_view()),
    path('/bookmark', BookmarkView.as_view()),
    path('/unbookmark', UnBookmarkView.as_view()),
    path('/mypage', MyPageView.as_view()),
]