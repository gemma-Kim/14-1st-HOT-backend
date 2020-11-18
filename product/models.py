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
    name           = models.CharField(max_length=200)
    seller         = models.ForeignKey('Seller', on_delete=models.SET_NULL, null=True)
    sub_categories = models.ForeignKey('SubCategory', on_delete=models.CASCADE)

    class Meta:
        db_table = 'collections'

    def __str__(self):
        return self.name


class Product(models.Model):
    name               = models.CharField(max_length=200)
    collection         = models.ForeignKey('Collection', on_delete=models.SET_NULL, null=True)
    additional_product = models.ManyToManyField('self', through ='SubProduct')

    class Meta:
        db_table = 'products'

    def __str__(self):
        return self.name


class SubProduct(models.Model):
    main_product = models.ForeignKey('Product', on_delete=models.CASCADE, related_name='main')
    sub_product  = models.ForeignKey('Product', on_delete=models.CASCADE, related_name='sub')

    class Meta:
        db_table = 'sub_products'


class ProductDetail(models.Model):
    color   = models.CharField(max_length=200)
    option  = models.JSONField("options")
    product = models.ForeignKey('Product', on_delete=models.CASCADE)

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
    durability   = models.DecimalField(max_digits=1,decimal_places=1)
    afforability = models.DecimalField(max_digits=1,decimal_places=1)
    design       = models.DecimalField(max_digits=1,decimal_places=1)
    delivery     = models.DecimalField(max_digits=1,decimal_places=1)

    class Meta:
        db_table = 'reviews'
