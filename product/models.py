from django.db import models

from post.models import TimeStampModel

class Menu(models.Model):
    name = models.CharField(max_length=200)

    class Meta:
        db_table = 'menus'


class Category(models.Model):
    name = models.CharField(max_length=200)
    menu = models.ForeignKey('Menu', on_delete=models.SET_NULL, null=True)

    class Meta:
        db_table = 'categories'


class SubCategory(models.Model):
    name     = models.CharField(max_length=200)
    category = models.ForeignKey('Category', on_delete=models.SET_NULL, null=True)

    class Meta:
        db_table = 'sub_categories'

    def __str__(self):
        return self.name


class Collection(models.Model):
    name         = models.CharField(max_length=200)
    seller       = models.ForeignKey('Seller', on_delete=models.SET_NULL, null=True)
    sub_category = models.ForeignKey('SubCategory', on_delete=models.CASCADE)

    class Meta:
        db_table = 'collections'

    def __str__(self):
        return self.name


class AdditionalProduct(models.Model):
    main_product = models.ForeignKey('Product', on_delete=models.CASCADE, related_name='main')
    sub_product  = models.ForeignKey('Product', on_delete=models.CASCADE, related_name='sub')

    class Meta:
        db_table = 'additional_products'


class Product(TimeStampModel):
    name                = models.CharField(max_length=200)
    menu                = models.ForeignKey('Menu', on_delete=models.CASCADE)
    category            = models.ForeignKey('Category', on_delete=models.CASCADE)
    sub_category        = models.ForeignKey('SubCategory', on_delete=models.CASCADE)
    collection          = models.ForeignKey('Collection', on_delete=models.SET_NULL, null=True)
    additional_products = models.ManyToManyField('self', through='AdditionalProduct', symmetrical=False)
    color               = models.ManyToManyField('Color', through ='ColorSet')
    seller              = models.ForeignKey('Seller', on_delete=models.SET_NULL, null=True)

    class Meta:
        db_table = 'products'

    def __str__(self):
        return self.name


class Color(models.Model):
    name = models.CharField(max_length=100)

    class Meta:
        db_table = 'colors'


class ColorSet(models.Model):
    product = models.ForeignKey('Product', on_delete=models.CASCADE)
    color   = models.ForeignKey('Color', on_delete=models.CASCADE)


class Size(models.Model):
    name = models.CharField(max_length=200)

    class Meta:
        db_table = 'sizes'


class ProductDetail(models.Model):
    product = models.ForeignKey('Product', on_delete=models.CASCADE)
    size    = models.ForeignKey('Size', on_delete=models.CASCADE, null=True)
    price   = models.DecimalField(max_digits=10, decimal_places=2)

    class Meta:
        db_table = 'product_details'


class ProductImage(models.Model):
    product_image_url = models.URLField(max_length=1000)
    product           = models.ForeignKey('Product', on_delete=models.CASCADE)

    class Meta:
        db_table = 'product_images'


class Seller(models.Model):
    name = models.CharField(max_length=200)

    class Meta:
        db_table = 'sellers'

    def __str__(self):
        return self.name


class Share(models.Model):
    user    = models.ForeignKey('user.User', on_delete=models.CASCADE)
    product = models.ForeignKey('Product', on_delete=models.CASCADE)


class Review(TimeStampModel):
    author       = models.ForeignKey('user.User', on_delete=models.SET_NULL, null=True)
    content      = models.TextField()
    review_image = models.URLField(max_length=200)
    product      = models.ForeignKey('Product', on_delete=models.CASCADE)
    durability   = models.DecimalField(max_digits=2,decimal_places=1)
    afforability = models.DecimalField(max_digits=2,decimal_places=1)
    design       = models.DecimalField(max_digits=2,decimal_places=1)
    delivery     = models.DecimalField(max_digits=2,decimal_places=1)

    class Meta:
        db_table = 'reviews'