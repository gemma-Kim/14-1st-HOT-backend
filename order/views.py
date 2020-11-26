import json

from django.views     import View
from django.http      import JsonResponse

from .models     import Cart, Order
from product.models import Product, ProductDetail, ProductImage, Seller, Size, Color
from user.models import User
from user.utils  import login_decorator


class AddItemView(View):
    @login_decorator
    def post(self, request):
        try:
            data = json.loads(request.body)
            for d in data:
                product = Product.objects.get(
                    id        = d['product_id'],
                    seller_id = Seller.objects.get(name=d['seller']).id
                )

                size      = d.get('label', None)
                size_id   = Size.objects.get(name=d['label']).id
                color_id  = Color.objects.get(name=d['color']).id
                detail_id = ProductDetail.objects.get(size_id=size_id, price=d['value'], product_id=product.id).id

                Cart.objects.create(product_id=product.id, size_id=size_id, user_id=request.user.id, quantity=d['count'], color_id=color_id)

            return JsonResponse({'message':'SUCCESS'}, status=200)

        except KeyError:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)


class DisplayCartView(View):
    @login_decorator
    def get(self, request):
        try:
            carts = Cart.objects.filter(user_id=request.user.id)
            product_ids = list(set([cart.product_id for cart in carts]))
            product     = Product.objects.prefetch_related('productimage_set')
            result      = []

            for product_id in product_ids:
                carts = Cart.objects.filter(user_id=request.user.id, product_id=product_id)

                result.append({
                    "product_id"   : product_id,
                    "product_name" : Product.objects.get(id=product_id).name,
                    "product_image": product.get(id=product_id).productimage_set.first().product_image_url,
                    "options"      : [
                        {
                            "color": Color.objects.get(id=cart.color_id).name,
                            "size" : Size.objects.get(id=cart.size_id).name,
                            "count": cart.quantity,
                            "price": ProductDetail.objects.get(product_id=product_id, size_id=cart.size_id).price
                        }
                            for cart in carts
                    ]
                    })

            return JsonResponse({'message':'SUCCESS', 'context': result}, status=200)

        except KeyError:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)
