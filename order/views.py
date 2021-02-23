import json

from django.db        import transaction
from django.db.models import Q
from django.http      import JsonResponse
from django.views     import View

from .models        import Cart, Order
from user.utils     import login_decorator
from user.models    import User
from product.models import Product, ProductDetail, ProductImage, Seller, Size, Color


class AddItemView(View):
    @transaction.atomic
    @login_decorator
    def post(self, request):
        try:
            carts = json.loads(request.body)
            for cart in carts:
                product_id = cart.get('product_id', None)
                size       = cart.get('label', None)
                color      = cart.get('color', None)
                quantity   = cart.get('count', "1")

                if product_id:
                    product = Product.objects.get(id=cart['product_id'])
                if size:
                    size   = Size.objects.get(name=size).id
                if color:
                    color  = Color.objects.get(name=color).id
                
                Cart.objects.create(
                    product_id=product.id, 
                    user_id=request.user.id,
                    order_id=None, 
                    quantity=quantity, 
                    color_id=color,
                    size_id=size 
                )

            return JsonResponse({'message':'SUCCESS'}, status=200)

        except KeyError:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)
        except Product.DoesNotExist:
            return JsonResponse({'message':'INVALID_PRODUCT'}, status=400)


class UpdateItemView(View):
    @transaction.atomic
    @login_decorator
    def patch(self, request, product_id):
        try:
            data  = json.loads(request.body)
            carts = data.get('carts', None)
            
            if not carts:
                return JsonResponse({'message':'NO_DATA'}, status=400)
                
            for cart in carts:
                new_cart = Cart.objects.get(id=cart.get('cart_id'))
                if new_cart:
                    new_cart.quantity = cart.get('count', "1")
                    new_cart.save()
            return JsonResponse({'message':'SUCCESS'}, status=200)

        except KeyError:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)
        except Cart.DoesNotExist:
            return JsonResponse({'message':'INVALID_CART'}, status=400)


class RemoveItemView(View):
    @login_decorator
    def post(self, request):
        try:
            data        = json.loads(request.body)
            product_ids = data.get("product_id", None)
            cart_id     = data.get('cart_id', None)
            
            if product_ids:
                cart_filter = Q(user_id=request.user.id)
                for product_id in product_ids:
                    cart_filter.add(Q(product_id=product_id), cart_filter.OR)
                carts = Cart.objects.filter(cart_filter)
                if carts:
                    with transaction.atomic():
                        carts.delete()
            
            if cart_id:
                cart = Cart.objects.get(id=cart_id, user_id=request.user.id)
                if cart:
                    with transaction.atomic():
                        cart.delete()
            
        except KeyError:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)
        except Cart.DoesNotExist:
            return JsonResponse({'message':'INVALID_CART'}, status=400)
        

class DisplayCartView(View):
    @login_decorator
    def get(self, request):
        try:
            carts       = Cart.objects.filter(user_id=request.user.id, order_id=None)
            product_ids = list(set([cart.product_id for cart in carts]))
            product     = Product.objects.prefetch_related('productimage_set')
            result      = []
            
            if product_ids:
                for product_id in product_ids:
                    carts = Cart.objects.filter(user_id=request.user.id, product_id=product_id)
                    result.append({
                        "product_id"   : product_id,
                        "product_name" : Product.objects.get(id=product_id).name,
                        "product_image": product.get(id=product_id).productimage_set.first().product_image_url,
                        "options"      : [
                            {
                                "cart_id": cart.id,
                                "color"  : cart.color.name,
                                "size"   : cart.size.name,
                                "count"  : cart.quantity,
                                "price"  : ProductDetail.objects.get(product_id=product_id, size_id=cart.size_id).price
                            }
                                for cart in carts
                        ]
                    })

                return JsonResponse({'message':'SUCCESS', 'context':result}, status=200)
            
            return JsonResponse({'message':"NO_DATA"}, status=200)

        except KeyError:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)