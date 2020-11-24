import json

from .models     import Cart
from user.models import User
from user.utils  import login_decortor


class AddItemView(View):
    @login_decorator
    def post(self, request):
        user = User.objects.get(id=request.user.id)
        data = 

