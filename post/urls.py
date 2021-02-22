from django.urls import path
from .views import CommentView, CommentModifyView, PostView, PostDetailView, LikeView, UnLikeView

urlpatterns = [
    path('/<int:post_id>', PostDetailView.as_view()),
    path('', PostView.as_view()),
    path('/<int:post_id>/comments', CommentView.as_view()),
    path('/<int:post_id>/comments/<int:comment_id>', CommentModifyView.as_view()),
    path('/<int:post_id>/like', LikeView.as_view()),
    path('/<int:post_id>/unlike', UnLikeView.as_view())
]