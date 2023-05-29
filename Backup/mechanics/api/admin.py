from django.contrib import admin
from .models import UserRegistration, MechanicRegistration, UserPayment, Detail, CarDetail

@admin.register(UserRegistration)
class UserAdmin(admin.ModelAdmin):
    list_display = ['id','Username', 'Password', 'User_Email', 'Full_Name', 'CNIC_Number', 'City', 'Contact_Number']

@admin.register(MechanicRegistration)
class MechanicAdmin(admin.ModelAdmin):
    list_display = ['id','Username', 'Password', 'Mechanic_Email', 'Full_Name', 'CNIC_Number', 'City', 'Contact_Number']

@admin.register(UserPayment)
class PaymentAdmin(admin.ModelAdmin):
    list_display = ['id','Name', 'Card_Number', 'cvv', 'Expiry_date']

@admin.register(Detail)
class DetailAdmin(admin.ModelAdmin):
    list_display = ['id','Workshop_Name', 'Workshop_Location', 'Workshop_Phone', 'Workshop_Services']

@admin.register(CarDetail)
class CarDetailAdmin(admin.ModelAdmin):
    list_display = ['id','Car_Company', 'Car_Model', 'Engine_Type', 'Engine_Capacity', 'Mileage']
