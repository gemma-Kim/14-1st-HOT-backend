from django.urls import path
from .views import AddItemView

urlpatterns = [
    path('/cart', AddItemView.as_view()),
]
