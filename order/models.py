import uuid

from django.db import models
from post.models import TimeStampModel


class Cart(models.Model):
    product_detail  = models.ForeignKey('product.ProductDetail', on_delete=models.CASCADE)
    user            = models.ForeignKey('user.User', on_delete=models.SET_NULL, null=True)
    order           = models.ForeignKey('Order', on_delete=models.SET_NULL, null=True)
    tracking_number = models.CharField(max_length=200, null=True)
    shipment        = models.CharField(max_length=30, default='쿠팜')
    quantity        = models.CharField(max_length=1000)
    color           = models.ForeignKey('product.Color', on_delete=models.CASCADE)

    class Meta:
        db_table = 'carts'


class Order(TimeStampModel):
    uuid   = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    status = models.ForeignKey('Status', on_delete=models.SET_NULL, null=True)

    class Meta:
        db_table = 'orders'


class Status(models.Model):
    name = models.CharField(max_length=100)

    class Meta:
        db_table = 'statuses'
