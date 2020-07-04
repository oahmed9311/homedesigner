from django.db import models
from django.conf import settings

# Create your models here.
class Project(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    name = models.CharField(max_length=30)
    overall_grade = models.CharField(max_length=2)
    orientation_grade = models.CharField(max_length=2)
    zoning_grade = models.CharField(max_length=2)
    waster_grade = models.CharField(max_length=2)
    created = models.DateTimeField(auto_now_add=True)
    
class Snapshot(models.Model):
    project = models.ForeignKey(Project, on_delete=models.CASCADE)
    parent = models.ForeignKey("self", null=True, on_delete=models.CASCADE)
    created = models.DateTimeField(auto_now_add=True)
    modified = models.DateTimeField(auto_now=True)
    content = models.BinaryField()
    