from rest_framework import serializers
from .models import UserRegistration, MechanicRegistration, UserPayment, Detail, CarDetail

class UserRegistrationSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserRegistration
        fields = ['id','Username', 'Password', 'User_Email', 'Full_Name', 'CNIC_Number', 'City', 'Contact_Number']
    
    def validate_Username(self, value):
        ModelClass = self.Meta.model
        if ModelClass.objects.filter(Username=value).exists():
            raise serializers.ValidationError('Username already exists')
        return value

    def validate_User_Email(self, value):
        ModelClass = self.Meta.model
        if ModelClass.objects.filter(User_Email=value).exists():
            raise serializers.ValidationError('Email already exists')
        return value
    
    def validate_CNIC_Number(self, value):
        ModelClass = self.Meta.model
        if ModelClass.objects.filter(CNIC_Number=value).exists():
            raise serializers.ValidationError('CNIC already exists')
        return value

class MechanicRegistrationSerializer(serializers.ModelSerializer):
    class Meta:
        model = MechanicRegistration
        fields = ['id','Username', 'Password', 'Mechanic_Email', 'Full_Name', 'CNIC_Number', 'City', 'Contact_Number','Services']

    def validate_Username(self, value):
        ModelClass = self.Meta.model
        if ModelClass.objects.filter(Username=value).exists():
            raise serializers.ValidationError('Username already exists')
        return value

    def validate_User_Email(self, value):
        ModelClass = self.Meta.model
        if ModelClass.objects.filter(Mechanic_Email=value).exists():
            raise serializers.ValidationError('Email already exists')
        return value

    def validate_CNIC_Number(self, value):
        ModelClass = self.Meta.model
        if ModelClass.objects.filter(CNIC_Number=value).exists():
            raise serializers.ValidationError('CNIC already exists')
        return value


class PaymentServicesSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserPayment
        fields = ['id','Name', 'Card_Number', 'cvv', 'Expiry_date']


class DetailSerializer(serializers.ModelSerializer):
    class Meta:
        model = Detail
        fields = ['Workshop_Name', 'Workshop_Location', 'Workshop_Phone', 'Workshop_Services', 'Mechanic_Email']

class CarDetailSerializer(serializers.ModelSerializer):
    class Meta:
        model = CarDetail
        fields = ['Car_Company', 'Car_Model', 'Engine_Type', 'Engine_Capacity', 'Mileage']
