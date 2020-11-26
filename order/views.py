import json

from django.views     import View
from django.http      import JsonResponse

from .models     import Cart, Order
from product.models import Product, ProductDetail, Seller, Size, Color
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

                Cart.objects.create(product_detail_id=detail_id, user_id=request.user.id, quantity=d['count'], color_id=color_id)

            return JsonResponse({'message':'SUCCESS'}, status=200)

        except KeyError:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)


class DisplayCartView(View):
    @login_decorator
    def get(self, request):
        try:
            carts           = Cart.objects.filter(user_id=request.user.id)
            product_details = list(set([cart.product_detail_id for cart in carts]))
            result          = []

            for cart in carts:
                if cart.product_detail_id in product_details:
                    result.append({
                        "product_id"   : cart.product_id,
                        "product_name" : Product.objects.get(id=cart.product_id).name,
                        "product_image": ProductImage.objects.get(product_id=cart.product_id).image_url,
                        "options"      : [
                            {
                                "color": Color.objects.get(id=cart.color_id).name,
                                "size" : ProductDetail.objects.get(id=cart.product_detail_id).size,
                                "count": cart.quantity
                            }
                            for cart in carts
                        ]
                    })

                    product_details.remove(cart.product_detail_id)

            return JsonResponse({'message':'SUCCESS', 'context': result}, status=200)

        except KeyError:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)
