import json

from django.views     import View
from django.http      import JsonResponse

from .models        import Cart, Order
from product.models import Product, ProductDetail, ProductImage, Seller, Size, Color
from user.models    import User
from user.utils     import login_decorator


class AddItemView(View):
    @login_decorator
    def post(self, request):
        try:
            carts = json.loads(request.body)
            for cart in carts:
                seller   = cart.get('seller', None)
                size     = cart.get('label', None)
                color    = cart.get('color', None)
                price    = cart.get('value', None)
                quantity = cart.get('count', "1")

                if seller:
                    product = Product.objects.get(
                        id        = cart['product_id'],
                        seller_id = Seller.objects.get(name=seller).id
                    )
                if size: 
                    size_id   = Size.objects.get(name=size).id
                if color:
                    color_id  = Color.objects.get(name=color).id
                if price:
                    detail_id = ProductDetail.objects.get(size_id=size_id, price=price, product_id=product.id).id

                Cart.objects.create(product_id=product.id, size_id=size_id, user_id=request.user.id, quantity=quantity, color_id=color_id)

            return JsonResponse({'message':'SUCCESS'}, status=200)

        except KeyError:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)
        except Product.DoesNotExist:
            return JsonResponse({'message':'INVALID_PRODUCT'}, status=400)


class UpdateItemView(View):
    @login_decorator
    def patch(self, request, product_id):
        try:
            data     = json.loads(request.body)
            seller   = data.get('seller', None)
            price    = data.get('value', None)
            quantity = data.get('count', None)
            size     = data.get('label', None)
            color    = data.get('color', None)

            if size:
                size = Size.objects.get(name=size).id
            if color:
                color = Color.objects.get(name=color).id

            cart = Cart.objects.get(
                product_id=cart.get('product_id'), 
                user_id=request.user.id,
                order_id=None,
                size_id=size,
                color_id=color,
                quantity=quantity
            )

            new_size     = data.get('new_size', None)
            new_color    = data.get('new_color', None)
            new_quantity = data.get('new_quantity', "1")

            if new_size:
                size_id = Size.objects.get(name=new_size).id
                cart.size_id = size_id
            if new_color:
                color_id = Size.objects.get(name=new_color).id
                cart.color_id = color_id
            if new_quantity:
                cart.quantity = new_quantity
            cart.save()

            return JsonResponse({'message':'SUCCESS'}, status=200)
        
        except KeyError:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)
        except Cart.DoesNotExist:
            return JsonResponse({'message':'INVALID_CART'}, status=400)


class RemoveItemView(View):
    @login_decorator
    def post(self, request):
        try:
            data       = json.loads(request.body)
            product_id = data.get("product_id", None)
            cart_ids   = data.get('cart_ids', None)
            
            if product_id and not cart_ids:
                carts = Cart.objects.filter(product_id=product_id, user_id=request.user.id)
                carts.delete()
            if not product_id and cart_ids:
                for cart_id in cart_ids:
                    cart = Cart.objects.get(id=cart_id)
                    if cart:
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