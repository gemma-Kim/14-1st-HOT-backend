from django.urls import path
from .views import AddItemView, DisplayCartView

urlpatterns = [
    path('/cart', AddItemView.as_view()),
    path('/mycart', DisplayCartView.as_view())
]
