# Generated by Django 3.1.3 on 2020-11-24 08:32

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('user', '0006_auto_20201122_2235'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='profile_image_url',
            field=models.URLField(default='https://cdn.pixabay.com/photo/2019/08/11/18/59/icon-4399701_960_720.png', max_length=1000, null=True),
        ),
    ]