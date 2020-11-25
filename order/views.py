import json

from django.views     import View
from django.http      import JsonResponse

from .models     import Cart, CartBox, Order, Status
from product.models import Product, ProductDetail, Seller, Size
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
                        cartbox_id        = cartbox_id
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
                        cartbox_id        = cartbox_id
                    )

            return JsonResponse({'message':'SUCCESS'}, status=200)

        except KeyError:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)


#class RemoveItemView(View):
#    @login_decorator
#    def post(self, request):
#        try:
#            data = json.loads(request.body)
#
#class DisplayCartView(View):
#    @login_decorator
#    def get(self, request):
#        carts = Cart.objects.filter(user_id=request.user.id)
#














