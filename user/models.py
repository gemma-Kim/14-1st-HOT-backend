import uuid

from django.db import models

from product.models import Product


class User(models.Model):
    username         = models.CharField(max_length=200)
    password         = models.CharField(max_length=1000)
    email            = models.EmailField()
    created_at       = models.DateTimeField(auto_now_add=True)
    updated_at       = models.DateTimeField(auto_now=True)
    follow           = models.ManyToManyField('self', through='Follow')
    product_bookmark = models.ManyToManyField('product.Product', through='ProductBookmark')
    post_bookmark    = models.ManyToManyField('post.Post', through='PostBookmark')

    class Meta:
        db_table = 'users'

    def __str__(self):
        return self.username


class ProfileImage(models.Model):
    profile_image_url = models.URLField(max_length=1000)
    user              = models.ForeignKey('User', on_delete=models.CASCADE)

    class Meta:
        db_table = 'profile_images'


class Follow(models.Model):
    follower = models.ForeignKey('User', on_delete=models.CASCADE, related_name='follower_user')
    followee = models.ForeignKey('User', on_delete=models.CASCADE, related_name='followee_user')

    class Meta:
        db_table = 'follows'


class ProductBookmark(models.Model):
    user    = models.ForeignKey('User', on_delete=models.CASCADE)
    product = models.ForeignKey('product.Product', on_delete=models.CASCADE)

    class Meta:
        db_table = 'product_bookmarks'


class PostBookmark(models.Model):
    user = models.ForeignKey('User', on_delete=models.CASCADE)
    post = models.ForeignKey('post.Post', on_delete=models.CASCADE)

    class Meta:
        db_table = 'post_bookmarks'


class Like(models.Model):
    user = models.ForeignKey('User', on_delete=models.CASCADE)
    post = models.ForeignKey('post.Post', on_delete=models.CASCADE)

    class Meta:
        db_table = 'likes'


class Cart(models.Model):
    product_detail  = models.ForeignKey('product.ProductDetail', on_delete=models.CASCADE)
    order           = models.ForeignKey('Order', on_delete=models.SET_NULL, null=True)
    shipment        = models.CharField(max_length=100)
    tracking_number = models.CharField(max_length=200)
    company         = models.CharField(max_length=100)

    class Meta:
        db_table = 'carts'


class Order(models.Model):
    uuid       = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user       = models.ForeignKey('User', on_delete=models.SET_NULL, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = 'orders'


class Status(models.Model):
    name = models.CharField(max_length=100)

    class Meta:
        db_table = 'statuses'
