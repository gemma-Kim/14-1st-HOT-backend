import uuid

from django.db import models
from post.models import TimeStampModel


class Cart(TimeStampModel):
    order           = models.ForeignKey('Order', on_delete=models.SET_NULL, null=True)
    shipment        = models.CharField(max_length=100, default='업체직접배송')
    tracking_number = models.CharField(max_length=200)
    product_detail  = models.ForeignKey('product.ProductDetail', on_delete=models.CASCADE)
    user            = models.ForeignKey('user.User', on_delete=models.CASCADE)

    class Meta:
        db_table = 'carts'


class Order(TimeStampModel):
    uuid           = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    status         = models.ForeignKey('Status', on_delete=models.CASCADE)

    class Meta:
        db_table = 'orders'


class Status(models.Model):
    name = models.CharField(max_length=100)

    class Meta:
        db_table = 'statuses'
