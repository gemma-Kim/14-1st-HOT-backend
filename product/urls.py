from django.urls import path

from .views import ProductListView, CategoryListView, ProductDetailView


urlpatterns = [
    path('/products', ProductListView.as_view()),
    path('/categories', CategoryListView.as_view()),
    path('/<int:product_id>', ProductDetailView.as_view(), name='product_detail'),
]
