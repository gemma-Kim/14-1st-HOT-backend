import json

from django.views import View
from django.http import JsonResponse



from .models import (
    Menu,
    Category,
    SubCategory,
    Collection,
    AdditionalProduct,
    Product,
    ProductDetail,
    ProductImage,
    Seller,
    Share
)



class ProductListView(View):

    #seller문제
    def get(self, request):
        data = json.loads(request.body)
        menu = Menu.objects.prefetch_related('category_set',
                                             'category_set__subcategory_set',
                                             'category_set__subcategory_set__product_set',
                                             'category_set__subcategory_set__product_set__productimage_set',
                                             'category_set__subcategory_set__product_set__seller',
                                             'category_set__subcategory_set__collection_set',
                                             'category_set__subcategory_set__collection_set__seller'
                                             ).get(id=data['menu_id'])
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
                                        'product_images':[ image.product_image_url for image in product.productimage_set.all()],
                                        'product_seller': product.seller.name
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
#        products = Product.objects.select_related(
#            'collection',
#            'collection__sub_cateory',
#            'collection__sub_cateory__category',
#            'collection__sub_cateory__category__menu'
#        ).prefetch_related('
#        context = [
#            {
#                'menu_id':products[0].collection.sub_category.category.menu.id,
#                'menu': products[0].collection.sub_category.category.menu.name,
#                'category_id': products[0].collection.sub_category.category.id,
#                'category': products[0].collection.sub_category.category.name,
#                'sub_category_id': products[0].collection.sub_category.id,
#                'sub_category': products[0].collection.sub_category.name,
#                'collection_id': products[0].collection.id,
#                'collection': products[0].collection.name,
#                'product_id': products[0].id,
#                'proudct': products[0].name
#                'image_url': product
#
#
#                'c': product.id,
#                'post_name': product.name,
#                'colelction': product.collection.name ,
#                '
