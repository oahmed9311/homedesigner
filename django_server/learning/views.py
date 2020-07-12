from django.shortcuts import render, redirect
from django.db import connection
from django.http import JsonResponse
import zlib
import pdb;

def extract_features(request):
    if not request.user.is_authenticated:
        return redirect('/home?requestlogin=true')
    if (request.method == 'POST'):
        query = "SELECT project.name, project.orientation_grade, project.waster_grade, project.zoning_grade, project.overall_grade, snapshot.content FROM floorplanner_project AS project, floorplanner_snapshot AS snapshot WHERE snapshot.project_id = project.id AND snapshot.parent_id is NULL;"
        with connection.cursor() as cursor:
            cursor.execute(query)
            posts_tuples = cursor.fetchall()
            posts_dict = []
            for name, orientation_grade, waster_grade, zoning_grade, overall_grade, content in posts_tuples:
                if content != None and len(content) != 0:
                    content = zlib.decompress(content).decode('utf-8')
                    posts_dict.append({'name':name, 'orientation_grade':orientation_grade, 'waster_grade':waster_grade, 'zoning_grade':zoning_grade, 'overall_grade':overall_grade, 'content':content})

        # Ur returning JSON andthhen you want to somehow
        # handle in via Jquery on the other side.

        # Why not just
        return JsonResponse(posts_dict, safe=False)
    else:
        return render(request, 'extract_features.html')


def train(request):
    if not request.user.is_authenticated:
        return redirect('/home?requestlogin=true')
    return render(request, 'learning_index.html')


def index(request):
    if not request.user.is_authenticated:
        return redirect('/home?requestlogin=true')
    return render(request, 'learning_index.html')
