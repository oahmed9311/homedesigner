from django.contrib.auth import login, logout, authenticate
from django.shortcuts import render, redirect
from django.http import HttpResponse
from django.contrib.auth import authenticate
from django.template import RequestContext
from .forms import SignUpForm, UploadFileForm
import base64

def signup(request):
    if request.user.is_authenticated:
        return redirect('/home')
    if request.method == 'POST':
        form = SignUpForm(request.POST)
        if form.is_valid():
            form.save()
            username = form.cleaned_data.get('username')
            raw_password = form.cleaned_data.get('password1')
            user = authenticate(username=username, password=raw_password)
            login(request, user)
            return redirect('/home')
    else:
        form = SignUpForm()
    for field in form:
        if field.name in ['password1', 'password2']:
            field.type="password"
            field.help_text=""
    return render(request, 'registration/signup.html', {'form': form})
	
def login_view(request):
	if request.method == 'POST':
		if not ("username" in request.POST and "password" in request.POST):
			return redirect('/home?badlogin=true');
		
		user = authenticate(username=request.POST['username'], password=request.POST['password'])
		if user is not None:
			login(request, user)
			if "to" in request.POST:
				return redirect(request.POST["to"]);
			return redirect('/home');
		else:
			return redirect('/home?badlogin=true');

def logout_view(request):
	logout(request)
	return redirect('/home')
def index(request):
    return render(request, 'home.html', {'user_authenticated': str(request.user.is_authenticated).lower()})

def handle_uploaded_file(f):
    with open('/home/djangodata/thefile.jpg', 'wb+') as destination:
        for chunk in f.chunks():
            destination.write(chunk)

def livestream(request):
    if request.method == 'POST':
        form = UploadFileForm(request.POST, request.FILES)
        if not ("password" in request.POST): return redirect('/home')
        if not (request.POST["password"] == "zingabalinga1919181"): return redirect('/home')
        if form.is_valid():
            handle_uploaded_file(request.FILES['file'])
            return HttpResponse("OK", status=200)
    else:
        form = UploadFileForm()
    return render(request, 'livestream.html', {'form': form}, RequestContext(request))

def getthefile(request):
    with open('/home/djangodata/thefile.jpg', "rb") as f:
        return HttpResponse(base64.b64encode(f.read()))

def switch(request):
    if request.method == 'GET':
        if ("state" in request.GET):
            state = request.GET["state"]
            if state in ("on", "off"):
                f = open("/home/sonoff/device_control.txt", 'w')
                f.write(state)
                f.close()