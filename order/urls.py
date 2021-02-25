from django.urls import path
from .views import AddItemView, DisplayCartView, UpdateItemView, RemoveItemView

urlpatterns = [
    path('', AddItemView.as_view()),
    path('/<int:product_id>', UpdateItemView.as_view()),
    path('', RemoveItemView.as_view()),
    path('/mycart', DisplayCartView.as_view()),
]