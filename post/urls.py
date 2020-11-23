from django.urls import path
from .views import CommentView

urlpatterns = [
    path('<int:post_id>/comments', CommentView.as_view()),
]
