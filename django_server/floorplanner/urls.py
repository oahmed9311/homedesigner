from django.urls import path

from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('project/', views.project, name='project'),
    path('projectSnapshots/', views.getProjectSnapshots, name='getProjectSnapshots'),
    path('saveSnapshot/', views.saveSnapshot, name='saveSnapshot'),
    path('loadSnapshot/', views.loadSnapshot, name='loadSnapshot'),
    path('takeSnapshot/', views.takeSnapshot, name='takeSnapshot'),
    path('deleteSnapshot/', views.deleteSnapshot, name='deleteSnapshot'),
    path('getUserProjects/', views.getUserProjects, name='getUserProjects'),
    path('getOtherUsersProjects/', views.getOtherUsersProjects, name='getOtherUsersProjects'),
    path('assignGrade/', views.assignGrade, name='assignGrade'),    
]