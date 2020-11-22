import json

from django.http      import JsonResponse
from django.views     import View
from django.db.models import Q

from post.models import Post, Comment
from user.models import User
from user.utils  import login_decorator

class CommentView(View):
    @login_decorator
    def post(self, request):
        user    = request.user
        data    = json.loads(request.body)
        post_id = request.GET.get('post', None)

        if not post_id:
            return JsonResponse({'message': 'CHECK_QUERYSTRING'}, status=400)

        if not 'content' in data:
            return JsonResponse({'message': 'KEY_ERROR'}, status=400)

        if not data['content'] or data['content'].isspace():
            return JsonResponse({'message': 'CONTENT_NULL'}, status=400)

        try:
            post = Post.objects.get(id=post_id)

        except Post.DoesNotExist:
            return JsonResponse({'message': 'INVALID_POST'}, status=400)

        created_comment = Comment.objects.create(
            content = data['content'],
            post    = post,
            author  = user
        )

        if 'parent' in data:
            try:
                comment = Comment.objects.get(id=data['parent'])

                created_comment.parent = comment
                created_comment.save()

            except Comment.DoesNotExist:
                return JsonResponse({'message': 'INVALID_COMMENT'}, status=400)

        return JsonResponse({'message': 'SUCCESS'}, status=200)
