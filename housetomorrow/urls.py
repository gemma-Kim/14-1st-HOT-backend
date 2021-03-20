from django.urls import path, include
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
)

urlpatterns = [
    # simple jwt
    path('api/token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    # endpoints
    path('users', include('user.urls')),
    path('store', include('product.urls')),
    path('posts', include('post.urls')),
    path('carts', include('order.urls'))
]