import json

from django.views import View
from django.http  import JsonResponse

from user.models  import ProductBookmark
from .models      import (
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

    #seller문제
    def get(self, request):
        try:
            category = request.GET['menu_id']
            if not Menu.objects.filter(id=category):
                return JsonResponse({'message': 'DoesNotExist'}, status=400)
            menu = Menu.objects.prefetch_related('category_set',
                                                 'category_set__subcategory_set',
                                                 'category_set__subcategory_set__product_set',
                                                 'category_set__subcategory_set__product_set__productbookmark_set',
                                                 'category_set__subcategory_set__product_set__productimage_set',
                                                 'category_set__subcategory_set__product_set__seller',
                                                 'category_set__subcategory_set__collection_set',
                                                 'category_set__subcategory_set__collection_set__seller',
                                                 'category_set__subcategory_set__product_set__review_set'
                                                 ).get(id=category)
        except KeyError:
            return JsonResponse({'message': 'KeyError'}, status=400)
        context = [
            {
                'menu_id': menu.id,
                'menu_name': menu.name,
                'categories': [
                    {
                        'category_id': category.id,
                        'category_name': category.name,
                        'sub_categories': [
                            {
                                'sub_category_id': subcategory.id,
                                'sub_category_name': subcategory.name,
                                'products': [
                                    {
                                        'product_id': product.id,
                                        'product_name': product.name,
                                        'product_images':[image.product_image_url for image in product.productimage_set.all()],
                                        'product_seller': product.seller.name,
                                        'number_of_product_bookmarks': product.productbookmark_set.count(),
                                        'is_product_bookmarked': product.productbookmark_set.filter(user_id=1).exists(),
                                        'reviews': product.review_set.count()
                                        # need to add rates
                                    }
                                    for product in subcategory.product_set.all()
                                ],
                                'collections': [
                                    {
                                        'collection_id': collection.id,
                                        'collection_name': collection.name,
                                        'collections_seller': collection.seller.name
                                    }
                                    for collection in subcategory.collection_set.all()
                                ]
                            }
                            for subcategory in category.subcategory_set.all()
                        ]
                    }
                    for category in menu.category_set.all()
                ]
            }
        ]
        return JsonResponse({'result': context}, status=200)


class ProductDetailView(View):
    def get(self,request, product_id):
        try:
            if not Product.objects.filter(id=product_id).exists():
                return JsonResponse({'message': 'ProductNotFound'}, status=400)
            products = Product.objects.prefetch_related('review_set',
                                                        'share_set',
                                                        'productbookmark_set',
                                                        'productdetail_set',
                                                        'productdetail_set__size',
                                                        'productdetail_set__color'
                                                        ).get(id=product_id)
        except KeyError:
            return JsonResponse({'message':'KeyError'}, status=400)
        context = [
            {
                'product_id': product_id,
                'product_name': products.name,
                'number_of_shares': products.share_set.count(),
                'number_of_reviews': products.review_set.count(),
                'number_of_product_bookmarks': products.productbookmark_set.count(),
                'details': [
                    {
                        'product_detail_id': detail.id,
                        'color': [detail.color.name],
                        'size': [detail.size.name],
                        'price': detail.price
                    }
                    for detail in products.productdetail_set.all()
                ]
            }
        ]
        return JsonResponse({'result':context}, status=200)
