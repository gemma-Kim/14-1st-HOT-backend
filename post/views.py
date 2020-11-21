
import json

from django.http import JsonResponse
from django.views import View
from django.db.models import Q

from post.models import Post, PostImage, ProductInPost, Comment, Tag, PostTag
from user.models import User
from user.utils import login_decorator

class PostView(View):
    @login_decorator
    def post(self, request):
        data = json.loads(request.body)
        user = request.user

        if not 'content' in data or not 'images' in data or not 'tags' in data:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)

        created_post = Post.objects.create(
            content = data['content'],
            author = user
        )

        try:
            if not data['images']:
                return JsonResponse({'message':'IMAGE_PLZ'}, status=400)

            for image in data['images']:
                PostImage.objects.create(
                    post = created_post,
                    image_url = image
                )

        except TypeError:
            return JsonResponse({'message':'IMAGES_TYPE_ERROR'}, status=400)

        try:
            if data['tags']:
                for tag in data['tags']:
                    created_tag = Tag.objects.create(name = tag)
                    PostTag.objects.create(
                        tag = created_tag,
                        post = created_post
                    )

            return JsonResponse({'message':'SUCCESS'}, status=200)

        except TypeError:
            return JsonResponse({'message':'TAGS_TYPE_ERROR'}, status=400)
