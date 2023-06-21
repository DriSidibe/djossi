from django.db import models

class Worker(models.Model):
    firstname = models.fields.CharField(max_length=100)
    lastname = models.fields.CharField(max_length=100)
    email = models.fields.CharField(max_length=100)
    tel = models.fields.CharField(max_length=100)
    job = models.fields.CharField(max_length=100)
    hashed_password = models.fields.CharField(max_length=600)
    profil_photo = models.fields.CharField(max_length=100)