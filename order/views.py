import json

from django.views     import View
from django.http      import JsonResponse

from .models     import Cart, CartBox, Order, Status
from product.models import Product, ProductDetail, Seller, Size, Color
from user.models import User
from user.utils  import login_decorator

class AddItemView(View):
    @login_decorator
    def post(self, request):
        try:
            datas = json.loads(request.body)
            CartBox.objects.create(user_id=request.user.id, product_id=datas[0]['product_id'])
            cartbox_id = CartBox.objects.all().last().id

            for data in datas:
                if 'label' in data:
                    product_detail_id = ProductDetail.objects.get(
                                            product_id = data['product_id'],
                                            size_id    = Size.objects.get(name=data['label']).id,
                                            price      = data['value']
                                        ).id

                    Cart.objects.create(
                        product_detail_id = product_detail_id,
                        user_id           = request.user.id,
                        quantity          = data['count'],
                        cartbox_id        = cartbox_id,
                        color_id          = ColorSet.objects.get(product_id=data['product_id']).color_id
                    )

                else:
                    product_detail_id = ProductDetail.objects.get(
                                            product_id = data['product_id'],
                                            size_id    = None,
                                            price      = data['value']
                                        ).id

                    Cart.objects.create(
                        product_detail_id = product_detail_id,
                        user_id           = request.user.id,
                        quantity          = data['count'],
                        cartbox_id        = cartbox_id,
                        color_id          = ColorSet.objects.get(product_id=data['product_id']).color_id
                    )

            return JsonResponse({'message':'SUCCESS'}, status=200)

        except KeyError:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)


class DisplayCartView(View):
    @login_decorator
    def get(self, request):
        context = [
            {
                'cartbox_id'   : cartbox.id,
                'product_image': cartbox.product.productimage_set.first().product_image_url,
                'options':[
                    {
                        'color': Color.objects.get(id=cart.color_id).name,
                        'size' : Size.objects.get(id=cart.product_detail.size_id).id,
                        'count': cart.quantity,
                        'value': cart.product_detail.price
                    }  for cart in Cart.objects.filter(user_id=request.user.id).select_related('product_detail')
                ]
            }   for cartbox in CartBox.objects.filter(user_id=request.user.id).select_related('product').prefetch_related('cart_set')
        ]

        return JsonResponse({'message':'SUCCESS', 'context': context}, status=200)
