import json

from faker       import Faker
from user.models import User
from user.utils  import login_decorator


#class AddItemView(View):
#    @login_decorator
#    def post(self, request):
#        kofake = Faker('ko_KR')
#        enfake = Faker('en_EN')
#
#        shipment        = kofake.name()
#        tracking_number = enfake.random_number()
#        company         = enfake.name()
#
#        user = User.objects.get(id=request.user.id)
#        product_id = request.GET.get('product', None)
#        quantity   = request.GET.get
#
#        if product_id:
#
