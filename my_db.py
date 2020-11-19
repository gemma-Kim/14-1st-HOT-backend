import os

import django
import csv
import sys

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "housetomorrow.settings")

django.setup()

from product.models import Menu, Category, SubCategory
#'Menu-Menu.csv'
with open('Menu-Menu.csv') as in_file:
    data_reader = csv.reader(in_file)
    next(data_reader, None)
    for row in data_reader:
        Menu.objects.create( name=row[0])

with open('category-category.csv') as in_file:
    data_reader = csv.reader(in_file)
    next(data_reader, None)
    for row in data_reader:
        if row[0]:
            m = Menu.objects.get(name=row[0])
        Category.objects.create(
            name=row[1],
            menu=m
       )

#with open('subcategory-subcategory.csv') as in_file:
#    data_reader = csv.reader(in_file)
#    next(data_reader, None)
#    for row in data_reader:
#        if row[0]:
#            categ = Category.objects.get(name=row[0])
#        SubCategory.objects.create(
#            name=row[1],
#            category=categ
#        )
