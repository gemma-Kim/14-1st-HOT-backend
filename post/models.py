from django.db import models

class TimeStampModel(models.Model):
    created_at = models.DateTimeField(auto_now_add = True)
    updated_at = models.DateTimeField(auto_now = True)

    class Meta:
        abstract = True

class Post(TimeStampModel):
    content    = models.TextField(null=True)
    author     = models.ForeignKey('user.User', on_delete=models.CASCADE)
    product    = models.ManyToManyField('product.Product', through='ProductInPost')
    tag        = models.ManyToManyField('Tag', through='PostTag')

    class Meta:
        db_table = 'posts'


class PostImage(models.Model):
    image_url = models.URLField(max_length=2000)
    post      = models.ForeignKey('Post', on_delete=models.CASCADE)

    class Meta:
        db_table = 'post_images'


class ProductInPost(models.Model):
    top_position  = models.CharField(max_length=10)
    left_position = models.CharField(max_length=10)
    post          = models.ForeignKey('Post', on_delete=models.CASCADE)
    product       = models.ForeignKey('product.Product', on_delete=models.CASCADE)

    class Meta:
        db_table = 'products_in_posts'


class Comment(TimeStampModel):
    content    = models.TextField()
    post       = models.ForeignKey('Post', on_delete=models.CASCADE)
    author     = models.ForeignKey('user.User', on_delete=models.CASCADE)
    parent     = models.ForeignKey('self', related_name='reply', on_delete=models.CASCADE)

    class Meta:
        db_table = 'comments'


class Tag(models.Model):
    name = models.CharField(max_length=45)

    class Meta:
        db_table = 'tags'


class PostTag(models.Model):
    post = models.ForeignKey('Post', on_delete=models.CASCADE)
    tag  = models.ForeignKey('Tag', on_delete=models.CASCADE)

    class Meta:
        db_table = 'post_tags'
