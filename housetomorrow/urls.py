from django.urls import path, include


urlpatterns = [
    path('users', include('user.urls')),
    path('store', include('product.urls')),
    path('posts', include('post.urls')),
]
