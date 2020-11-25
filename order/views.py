import json

from User.utils import login_decorator

class AddItemView(View):
    @login_decorator
    def post(self, request):
        try:
            data = json.loads(reques.body)
            user = User.objects.get(id=request.user.id)
            product = Product.objects.get(id=data['product_id'])
            product_name = Product.objects.get(name=data['product_name'])

            Cart.objects.create(product_detail_id=detail
