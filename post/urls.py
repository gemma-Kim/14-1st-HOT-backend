from django.urls import path
<<<<<<< HEAD
from .views import CommentView, PostView, PostDetailView

urlpatterns = [
    path('/<int:post_id>', PostDetailView.as_view()),
    path('', PostView.as_view()),
    path('<int:post_id>/comments', CommentView.as_view()),
]
