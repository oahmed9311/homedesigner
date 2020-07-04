from django.shortcuts import render, redirect
from django.http import HttpResponse
from .models import Project, Snapshot
from django.http import JsonResponse
from django.core import serializers
from django.contrib.auth.models import User
from django.db.models import Subquery
from django.core.serializers.json import DjangoJSONEncoder
import json
import zlib 

def project(request):
    if request.user.is_authenticated:
        if request.method == 'GET' and 'id' in request.GET:
            projectId = int(request.GET['id'])
            try:
                project = Project.objects.get(pk=projectId)
            except:
                project = None
            if not project or not (project.user == request.user or request.user.is_superuser): return HttpResponse('Unauthorized', status=401)
            no_save = False
            if project.user != request.user: no_save = True
            return render(request, 'floorplanner.html', {'project_id':projectId, 'project_name':project.name, 
                                                        'orientation_grade':project.orientation_grade, 'zoning_grade':project.zoning_grade, 
                                                        'waster_grade':project.waster_grade, 'overall_grade':project.overall_grade})
    else:
        return redirect('/home?requestlogin=true');

def getProjectSnapshots(request):
    if not request.user.is_authenticated: return redirect('/home?requestlogin=true')
    if not request.method == 'GET' or not 'project_id' in request.GET: return HttpResponse('Unauthorized', status=401)
    projectId = int(request.GET['project_id'])
    try:
        project = Project.objects.get(pk=projectId)
    except:
        project = None
    if not project or not (project.user == request.user or request.user.is_superuser): return HttpResponse('Unauthorized', status=401)
    
    json = projectSnapshots(project)
    return JsonResponse(json, safe=False)
def projectSnapshots(project):
    projectId = project.id
    activeSnapshot = Snapshot.objects.filter(project=project).order_by('-modified')[0]
    parentSnapshot = Snapshot.objects.get(project=project, parent=None)
    parentSnapshotName = 'Snapshot-%d/%d %s'%(projectId, parentSnapshot.id, str(parentSnapshot.created)[:19])
    if parentSnapshot == activeSnapshot: parentSnapshotName += ' (active)'
    snapshotQueue = {parentSnapshot:[]}
    json=[{'name':parentSnapshotName, 'children': snapshotQueue[parentSnapshot]}]
    while len(snapshotQueue) != 0:
        parentSnapshot = next(iter(snapshotQueue))
        childrenSnapshots = Snapshot.objects.filter(parent=parentSnapshot).order_by('modified')
        for snapshot in childrenSnapshots:
            snapshotName = 'Snapshot-%d/%d %s'%(projectId, snapshot.id, str(snapshot.created)[:19])
            if snapshot == activeSnapshot: snapshotName += ' (active)'
            snapshotQueue[snapshot] = []
            snapshotQueue[parentSnapshot].append({'name': snapshotName, 'children': snapshotQueue[snapshot]})
        snapshotQueue.pop(parentSnapshot)
    return json
def saveSnapshot(request):
    if not request.user.is_authenticated: return redirect('/home?requestlogin=true')
    if not request.method == 'POST' or not 'project_id' in request.POST or not 'save_data' in request.POST: return HttpResponse('Unauthorized', status=401)
    projectId = int(request.POST['project_id'])
    try:
        project = Project.objects.get(pk=projectId)
    except:
        project = None
    if not project or not (project.user == request.user or request.user.is_superuser): return HttpResponse('Unauthorized', status=401)
    activeSnapshot = Snapshot.objects.filter(project=project).order_by('-modified')[0]
    compressed = zlib.compress(request.POST['save_data'].encode('utf-8'), 2)
    activeSnapshot.content = compressed
    activeSnapshot.save()
    return HttpResponse('ok', status=200)

def takeSnapshot(request):
    if not request.user.is_authenticated: return redirect('/home?requestlogin=true')
    if not request.method == 'POST' or not 'project_id' in request.POST or not 'save_data' in request.POST: return HttpResponse('Unauthorized', status=401)
    projectId = int(request.POST['project_id'])
    try:
        project = Project.objects.get(pk=projectId)
    except:
        project = None
    if not project or not project.user == request.user: return HttpResponse('Unauthorized', status=401)
    activeSnapshot = Snapshot.objects.filter(project=project).order_by('-modified')[0]
    compressed = zlib.compress(request.POST['save_data'].encode('utf-8'), 2)
    snapshot = Snapshot(project=project, parent=activeSnapshot)
    snapshot.content = compressed
    snapshot.save()
    json = projectSnapshots(project)
    return JsonResponse(json, safe=False)
    

def loadSnapshot(request):
    if not request.user.is_authenticated: return redirect('/home?requestlogin=true')
    if not request.method == 'POST' or not 'project_id' in request.POST: return HttpResponse('Unauthorized', status=401)
    projectId = int(request.POST['project_id'])
    try:
        project = Project.objects.get(pk=projectId)
    except:
        project = None
    if not project or not (project.user == request.user or request.user.is_superuser): return HttpResponse('Unauthorized', status=401)
    if 'snapshot_id' in request.POST:
        snapshotId = request.POST['snapshot_id'];
        if snapshotId.find(' ') != -1: snapshotId = snapshotId[:snapshotId.find(' ')]
        snapshotId = int(snapshotId)
        snapshot = Snapshot.objects.get(pk=snapshotId)
        if not snapshot.project == project: return HttpResponse('Unauthorized', status=401) 
        #touch!
        snapshot.save()
    else: #get active snapshot
        snapshot = Snapshot.objects.filter(project=project).order_by('-modified')[0]
    content = snapshot.content
    if content != None and len(content) != 0:
        content = zlib.decompress(content).decode('utf-8')
    return HttpResponse(content, content_type='text/plain')

def deleteSnapshot(request):
    if not request.user.is_authenticated: return redirect('/home?requestlogin=true')
    if not request.method == 'POST' or not 'project_id' in request.POST or not 'snapshot_id' in request.POST: return HttpResponse('Unauthorized', status=401)
    projectId = int(request.POST['project_id'])
    try:
        project = Project.objects.get(pk=projectId)
    except:
        project = None
    if not project or not (project.user == request.user or request.user.is_superuser): return HttpResponse('Unauthorized', status=401)
    snapshotId = request.POST['snapshot_id'];
    if snapshotId.find(' ') != -1: snapshotId = snapshotId[:snapshotId.find(' ')]
    snapshotId = int(snapshotId)
    snapshot = Snapshot.objects.get(pk=snapshotId)
    if not snapshot.project == project or snapshot.parent == None: return HttpResponse('Unauthorized', status=401) 
    snapshot.delete()
    return HttpResponse('ok', status=200)

def getUserProjects(request):
    if not request.user.is_authenticated: return redirect('/home?requestlogin=true')
    if not request.method == 'POST': return HttpResponse('Unauthorized', status=401)
    projects = Project.objects.filter(user=request.user).order_by('id')
    json = serializers.serialize("json", projects)
    return JsonResponse(json, safe=False)
    
    
def getOtherUsersProjects(request):
    if not request.user.is_authenticated: return redirect('/home?requestlogin=true')
    if not request.method == 'POST' or not request.user.is_superuser: return HttpResponse('Unauthorized', status=401)
    projects = Project.objects.all().exclude(user=request.user).values('id', 'user__username', 'name', 'created', 'orientation_grade', 'zoning_grade', 'waster_grade', 'overall_grade').order_by('id')
    json_response = json.dumps(list(projects), cls=DjangoJSONEncoder)
    #json = serializers.serialize("json",projects)
    return JsonResponse(json_response, safe=False)

def assignGrade(request):
    if not request.user.is_authenticated: return redirect('/home?requestlogin=true')
    if (not request.method == 'POST' or not 'project_id' in request.POST or not 'grades' in request.POST 
        or not request.user.is_superuser): return HttpResponse('Unauthorized1', status=401)
    projectId = int(request.POST['project_id'])
    try:
        project = Project.objects.get(pk=projectId)
    except:
        project = None
    if not project: return HttpResponse('Unauthorized2', status=401)
    grades = request.POST['grades'].split(' ')
    if len(grades) != 4: return HttpResponse('Unauthorized3', status=401)
    for grade in grades:
        if not grade in ['A', 'A-', 'B', 'B-', 'C', 'C-', 'D', 'D-', 'F']:
            return HttpResponse('Unauthorized4', status=401)
    project.orientation_grade = grades[0]
    project.zoning_grade = grades[1]
    project.waster_grade = grades[2]
    project.overall_grade = grades[3]
    project.save()
    return HttpResponse('ok', status=200)
    
def index(request):
    if not request.user.is_authenticated:
        return redirect('/home?requestlogin=true')
    if request.method == 'POST':
        if not 'user_action' in request.POST:
            return render(request, 'floorplanner_index.html')
        if request.POST['user_action'] == 'new_project' and 'new_project_name' in request.POST and request.POST['new_project_name'].strip() != '':
            newProjectName = request.POST['new_project_name'].strip();
            project = Project(user=request.user, name=newProjectName)
            project.save()
            snapshot = Snapshot(project=project)
            snapshot.save()
            return redirect('/floorplanner/project?id=%d' % project.id)
        else:
            return render(request, 'floorplanner_index.html')
    else:
        return render(request, 'floorplanner_index.html')
	