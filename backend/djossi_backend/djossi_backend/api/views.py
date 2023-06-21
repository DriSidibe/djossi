from django.http import HttpResponse
import json

from api.models import Worker

def all_workers(request):
    workers = Worker.objects.all()
    workers_json = {}
    for i in range(len(workers)):
        workers_json[workers[i].pk] = {
            'firstname' : workers[i].firstname,
            'lastname' : workers[i].lastname,
            'email' : workers[i].email,
            'tel' : workers[i].tel,
            'job' : workers[i].job,
            'hashed_password' : workers[i].hashed_password,
            'profil_photo' : workers[i].profil_photo,
        }
    
    return HttpResponse(json.dumps(workers_json, indent = 4))

def worker(request, id):
    try:
        worker = Worker.objects.get(pk=id)
        worker_json = {}
        worker_json[worker.pk] = {
            'firstname' : worker.firstname,
            'lastname' : worker.lastname,
            'email' : worker.email,
            'tel' : worker.tel,
            'job' : worker.job,
            'hashed_password' : worker.hashed_password,
            'profil_photo' : worker.profil_photo,
        }
        return HttpResponse(json.dumps(worker_json, indent = 4))
    except:
        return HttpResponse('worker not found')
    
def add_worker(request):
    property_count = 7
    request_obj = list(request.GET.keys())
    properties = ['firsname', 'lastname','email','job','profil_photo','hashed_password','tel']
    is_url_ok = False
    if len(request_obj) == property_count:
        for p in properties:
            if p not in request_obj:
                is_url_ok = False
                return HttpResponse('url not valid')
            is_url_ok = True
    else:
        return HttpResponse('url not valid')
    new_worker_dict = {'firsname':request_obj.get('firstname', ''), 'lastname':request_obj.get('lastname', ''),'email':request_obj.get('email', ''),'job':request_obj.get('job', ''),'profil_photo':request_obj.get('profil_photo', ''),'hashed_password':request_obj.get('hashed_password', ''),'tel':request_obj.get('tel', '')}
    if is_url_ok:
        new_worker = Worker(**new_worker_dict)
        new_worker.save()
    return HttpResponse('new worker added successfully!')
        
   

def hello(request):
    return HttpResponse('''<div>
                        <h1>DJOSSI BACKEND API</h1>
                        </div>''')