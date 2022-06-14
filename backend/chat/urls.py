from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from chat.views import *

urlpatterns = [
    path('rooms/', room_list),
    path('rooms/<str:pk>', room_details),
]

urlpatterns = format_suffix_patterns(urlpatterns)
