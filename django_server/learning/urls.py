from django.urls import path

from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('extract_features/', views.extract_features, name='extract_features'),
    path('train/', views.train, name='train'),

]