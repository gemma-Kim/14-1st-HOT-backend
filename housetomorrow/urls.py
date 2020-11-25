from django.urls import path, include


urlpatterns = [
    path('user', include('user.urls')),
    path('store', include('product.urls')),
    path('posts', include('post.urls')),
    path('order', include('order.urls'))
]
