from django.urls import path
from .views import PostView, PostDetailView

urlpatterns = [
    path('/<int:post_id>', PostDetailView.as_view()),
    path('', PostView.as_view()),
]
