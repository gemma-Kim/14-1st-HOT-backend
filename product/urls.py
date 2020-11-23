from django.urls import path, include

from .views import ProductListView, ProductDetailView


urlpatterns = [
    path('/category', ProductListView.as_view(), name='product_list'),
    path('/<int:product_id>', ProductDetailView.as_view(), name='product_detail'),
]
