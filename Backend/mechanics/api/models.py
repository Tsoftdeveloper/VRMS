from django.db import models
from django.core.validators import RegexValidator

class UserRegistration(models.Model):
    Username = models.CharField(max_length=50)
    Password = models.CharField(max_length=20)
    User_Email = models.EmailField(max_length = 254, default="abc@abc.com")
    Full_Name = models.CharField(max_length=100)
    CNIC_Number = models.CharField(max_length=15,validators=[RegexValidator(regex='^[0-9+]{5}-[0-9+]{7}-[0-9]{1}$', message='Invalid CNIC Number',),])
    City = models.CharField(max_length=50)
    Contact_Number = models.CharField(max_length=12, validators=[RegexValidator(regex='^((\\+92)?(0092)?(92)?(0)?)(3)([0-9]{9})$', message='Invalid Phone Number',),])

class MechanicRegistration(models.Model):
    Username = models.CharField(max_length=50)
    Password = models.CharField(max_length=20)
    Mechanic_Email = models.EmailField(max_length = 254,default="abc@abc.com")
    Full_Name = models.CharField(max_length=100)
    CNIC_Number = models.CharField(max_length=15,validators=[RegexValidator(regex='^[0-9+]{5}-[0-9+]{7}-[0-9]{1}$', message='Invalid CNIC Number',),])
    City = models.CharField(max_length=50)
    Contact_Number = models.CharField(max_length=12, validators=[RegexValidator(regex='^((\\+92)?(0092)?(92)?(0)?)(3)([0-9]{9})$', message='Invalid Phone Number',),])
    Services = models.CharField(max_length=550, null=True)
    Experience = models.CharField(max_length=50, default=0)

class UserPayment(models.Model):
    Name = models.CharField(max_length=50)
    Card_Number = models.CharField(max_length=20,validators=[RegexValidator(regex='^4[0-9]{12}(?:[0-9]{3})?$', message='Invalid Format',),])
    cvv = models.CharField(max_length=3)
    Expiry_date = models.DateField()

class Detail(models.Model):
    Workshop_Name = models.CharField(max_length=50)
    Workshop_Location = models.CharField(max_length=50)
    Workshop_Phone = models.CharField(max_length=20)
    Workshop_Services = models.CharField(max_length=550, null=True)

class CarDetail(models.Model):
    Car_Company = models.CharField(max_length=50)
    Car_Model = models.CharField(max_length=50)
    Engine_Type = models.CharField(max_length=20)
    Engine_Capacity = models.CharField(max_length=550)
    Mileage = models.CharField(max_length=550)

