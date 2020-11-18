from django.db import models

from product.models import Product
from post.models    import TimeStampModel

class User(TimeStampModel):
    username          = models.CharField(max_length=200)
    password          = models.CharField(max_length=1000)
    email             = models.EmailField()
    profile_image_url = models.URLField(max_length=1000, null=True)
    follow            = models.ManyToManyField('self', through='Follow',symmetrical=False)
    product_bookmark  = models.ManyToManyField('product.Product', through='ProductBookmark')
    post_bookmark     = models.ManyToManyField('post.Post', through='PostBookmark')

    class Meta:
        db_table = 'users'

    def __str__(self):
        return self.username


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
