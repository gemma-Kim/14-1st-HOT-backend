from django.urls import path, include
from .views      import AddItemView

urlpatterns = [
    path('/product/<int:id>', AddItemView.as_view())
    path('/collection/<int:id>', AddItemView.as_view())
]
