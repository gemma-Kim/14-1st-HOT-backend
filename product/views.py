import json

from django.views     import View
from django.http      import JsonResponse
from django.db.models import Q

from user.utils       import login_decorator
from user.models      import ProductBookmark
from .models          import (
    Menu,
    Category,
    SubCategory,
    Collection,
    AdditionalProduct,
    Product,
    ProductDetail,
    ProductImage,
    Seller,
    Share,
    Review
)


class ProductListView(View):
    @login_decorator
    def get(self, request):
        try:
            user_id = request.user.id

            menu_id         = request.GET.get('menu', None)
            category_id     = request.GET.get('cat', None)
            subcategory_id  = request.GET.get('sub', None)

            order   = request.GET.get('order', '0')
            search  = request.GET.get('search', None)

            sort_set = {
                '0' : 'id',
                '1' : '-id'
            }

            condition = Q()
            if search:
                condition &= Q(name__contains=search) | Q(seller__name__contains=search)

            products = Product.objects.filter(Q(menu_id=menu_id) |
                                              Q(category_id=category_id) |
                                              Q(sub_category_id=subcategory_id))\
                .select_related('menu', 'category', 'sub_category', 'collection', 'seller')\
                .prefetch_related('review_set', 'productbookmark_set', 'productimage_set')\
                .filter(condition)\
                .order_by(sort_set[order])


            context = [
                {
                    'product_id'               : product.id,
                    'product'                  : product.name,
                    'product_image'            : [product.product_image_url for product in product.productimage_set.all()],
                    'product_price'            : [detail.price for detail in product.productdetail_set.all()],
                    'collection'               : str(product.collection),
                    'product_seller'           : product.seller.name,
                    'number_of_reviews'        : product.review_set.count(),
                    'rates'                    : [(review.durability + review.afforability + review.design + review.delivery)/4
                                                  for review in product.review_set.all()],
                    'number_of_post_bookmarks' : product.productbookmark_set.count(),
                    'is_bookmarked'            : product.productbookmark_set.filter(user_id=user_id).exists()
                }
                for product in products
            ]

            return JsonResponse({'result': context}, status=200)
        except KeyError:
            return JsonResponse({'message':'KeyError'},status=400)


class CategoryListView(View):
    def get(self, request):
        try:
            menu_id = request.GET.get('menu', None)
            if not menu_id:

                menus = Menu.objects.prefetch_related('category_set','category_set__subcategory_set')
                context = [
                    {
                        'menu_id': menu.id,
                        'menu_name': menu.name
                    }
                    for menu in menus
                ]
                return JsonResponse({'result': context}, status=200)

            menu = Menu.objects.prefetch_related('category_set',
                                                 'category_set__subcategory_set'
                                                 ).get(id=menu_id)

            context = {
                    'menu_id'   : menu.id,
                    'menu_name' : menu.name,
                    'categories': [
                        {
                            'category_id': category.id,
                            'category_name':category.name,
                            'subcategories': [
                                {
                                    'subcategory_id': subcategory.id,
                                    'subcategory_name': subcategory.name
                                }
                                for subcategory in category.subcategory_set.all()
                            ]
                        }
                        for category in menu.category_set.all()
                    ]
            }
            return JsonResponse({'result': context}, status=200)
        except KeyError:
            return JsonResponse({'message':'KeyError'}, status=400)


class ProductDetailView(View):
    @login_decorator
    def get(self,request, product_id):
        try:
            user_id = request.user.id


            if not Product.objects.filter(id=product_id).exists():
                return JsonResponse({'mesage': 'ProductNotFound'}, status=400)
            products = Product.objects.select_related('seller', 'menu', 'category')\
                .prefetch_related('additional_products','share_set', 'review_set', 'productbookmark_set', 'productdetail_set', 'productimage_set')\
                .get(id=product_id)
            context=[
                {
                    'menu'                     : products.menu.name,
                    'category'                 : products.category.name,
                    'subcategory'              : products.sub_category.name,
                    'collection'               : products.collection.name,
                    'product_id'               : products.id,
                    'product_name'             : products.name,
                    'product_seller'           : products.seller.name,
                    'product_image_url'        : [image.product_image_url for image in products.productimage_set.all()],
                    'additional_products'      : [product.name for product in products.additional_products.all()],
                    'number_of_reviews'        : products.review_set.count(),
                    'product_rates'            : [(review.durability + review.afforability + review.design + review.delivery)/4
                                                  for review in products.review_set.all()],
                    'number_of_post_bookmarks' : products.productbookmark_set.count(),
                    'number_of_shares'         : products.share_set.count(),
                    'color'                    : [color.name for color in products.color.all()],
                    'details'                  :[
                        {
                            'size' : detail.size.name,
                            'price': detail.price
                        }
                        for detail in products.productdetail_set.all()
                    ]
                }
            ]
        except KeyError:
            return JsonResponse({'message': 'KeyError'}, stauts=400)
        return JsonResponse({'result':context}, status=200)
