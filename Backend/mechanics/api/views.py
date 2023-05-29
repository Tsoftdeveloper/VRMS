from .models import UserRegistration, MechanicRegistration, UserPayment, Detail, CarDetail
from .serializers import MechanicUpdateSerializer, UserRegistrationSerializer, MechanicRegistrationSerializer, PaymentServicesSerializer, DetailSerializer, CarDetailSerializer
from rest_framework.viewsets import GenericViewSet
from rest_framework.response import Response
from rest_framework import status
from rest_framework.renderers import JSONRenderer
from django.http import HttpResponse
from django.shortcuts import render
import json

class UserViewSet(GenericViewSet):
    queryset = UserRegistration.objects.all()
    serializer_class = UserRegistrationSerializer

    def retrieve(self, request, pk=None,):
        id = pk
        if id is not None:
            user = UserRegistration.objects.get(id=id)
            serializer = UserRegistrationSerializer(user)
            return Response(serializer.data)

    def create(self, request):
        serializer = UserRegistrationSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response({'Message':'User Created'}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)    

    def list(self, request):
        user = UserRegistration.objects.all()
        serializer = UserRegistrationSerializer(user, many=True)
        return Response(serializer.data)

    def update(self, request, pk=None):
        id = pk
        user =  UserRegistration.objects.get(id=id)
        serializer = UserRegistrationSerializer(user, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response({'Message':'User Updated'}, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)    

    def partial_update(self, request, pk=None):
        id = pk
        user =  UserRegistration.objects.get(id=id)
        serializer = UserRegistrationSerializer(user, data=request.data, partial = True)
        if serializer.is_valid():
            serializer.save()
            return Response({'Message':'Partial Data Updated'}, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)    

    def destroy(self, request, pk):
        id = pk
        user = UserRegistration.objects.get(id=id)
        user.delete()
        return Response({'Message':'Data Deleted'}, status=status.HTTP_200_OK)

class MechanicViewSet(GenericViewSet):
    queryset = MechanicRegistration.objects.all()
    serializer_class = MechanicRegistrationSerializer

    def retrieve(self, request, pk=None,):
        id = pk
        if id is not None:
            user = MechanicRegistration.objects.get(Username=id)
            serializer = MechanicRegistrationSerializer(user)
            return Response(serializer.data)

    def create(self, request):
        serializer = MechanicRegistrationSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response({'Message':'User Created'}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)    

    def list(self, request):
        user = MechanicRegistration.objects.all()
        serializer = MechanicRegistrationSerializer(user, many=True)
        return Response(serializer.data)

    def update(self, request, pk=None):
        id = pk
        user =  MechanicRegistration.objects.get(Username=id)
        serializer = MechanicRegistrationSerializer(user, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response({'Message':'User Updated'}, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)    

    def partial_update(self, request, pk=None):
        id = pk
        user =  MechanicRegistration.objects.get(Username=id)
        serializer = MechanicRegistrationSerializer(user, data=request.data, partial = True)
        if serializer.is_valid():
            serializer.save()
            return Response({'Message':'Partial Data Updated'}, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)    

    def destroy(self, request, pk):
        id = pk
        user = MechanicRegistration.objects.get(Username=id)
        user.delete()
        return Response({'Message':'Data Deleted'}, status=status.HTTP_200_OK)

class UserLoginAPI(GenericViewSet):
    queryset = UserRegistration.objects.all()
    serializer_class = UserRegistrationSerializer

    def create(self, request):
        serializer = UserRegistrationSerializer(data=request.data)
        userEmail = ""
        userPassword = ""
        email = request.data.get('User_Email')
        password = request.data.get('Password')
        user = UserRegistration.objects.all()
        serializer = UserRegistrationSerializer(user, many=True)
        for i in range(0,len(serializer.data)):
            for key, value in serializer.data[i].items():
                if(key == "User_Email" and value == email):
                    print(value)
                    userEmail = value
                    userPassword = serializer.data[i].get('Password')
        print(userEmail,userPassword)
        if(userEmail == email and userPassword == password):
            return Response({'Message':'Login Approved'}, status=status.HTTP_200_OK)
        elif(userEmail != email or userPassword != password):
            return Response({'Message':'Login Failed'}, status=status.HTTP_401_UNAUTHORIZED)
        
class MechanicLoginAPI(GenericViewSet):
    queryset = MechanicRegistration.objects.all()
    serializer_class = MechanicRegistrationSerializer

    def create(self, request):
        serializer = MechanicRegistrationSerializer(data=request.data)
        userEmail = ""
        userPassword = ""
        email = request.data.get('Mechanic_Email')
        password = request.data.get('Password')
        user = MechanicRegistration.objects.all()
        serializer = MechanicRegistrationSerializer(user, many=True)
        for i in range(0,len(serializer.data)):
            for key, value in serializer.data[i].items():
                if(key == "Mechanic_Email" and value == email):
                    userEmail = value
                    userPassword = serializer.data[i].get('Password')
        if(userEmail == email and userPassword == password):
            return Response({'Message':'Login Approved'}, status=status.HTTP_200_OK)
        elif(userEmail != email or userPassword != password):
            return Response({'Message':'Login Failed'}, status=status.HTTP_401_UNAUTHORIZED)
        
class MechanicServices(GenericViewSet):
    queryset = MechanicRegistration.objects.all()
    serializer_class = MechanicRegistrationSerializer

    def create(self, request):
        serializer = MechanicRegistrationSerializer(data=request.data)
        MechanicsOnServices = {}
        requestedServices = request.data.get('Services')
        user = MechanicRegistration.objects.all()
        serializer = MechanicRegistrationSerializer(user, many=True)
        for i in range(0,len(serializer.data)):
            for key, value in serializer.data[i].items():
                if(key == "Services" and value == requestedServices):
                    MechanicsOnServices[i] = serializer.data[i];
       
        json_data = JSONRenderer().render(MechanicsOnServices)
        print(json_data)
        if(json_data):
            return Response(json_data,status=status.HTTP_200_OK)
        else:
            return Response({'Message':'No Services'}, status=status.HTTP_401_UNAUTHORIZED)
        
class PaymentServices(GenericViewSet):
    queryset = UserPayment.objects.all()
    serializer_class = PaymentServicesSerializer
    
    def create(self, request):
        print(request)
        return Response(json.dumps({'Message':'Payment Approved'}),status=status.HTTP_200_OK)
    

class MechianicServiceResponse(GenericViewSet):
     queryset = UserRegistration.objects.all()
     serializer_class = UserRegistrationSerializer
    
     def create(self, request):
        return Response(json.dumps({'Message':'Request accepted'}),status=status.HTTP_200_OK)


class UserByEmail(GenericViewSet):
    queryset = UserRegistration.objects.all()
    serializer_class = UserRegistrationSerializer

    def create(self, request):
        serializer = UserRegistrationSerializer(data=request.data)
        userEmail = ""
        userPassword = ""
        make = {}
        email = request.data.get('User_Email')
        password = request.data.get('Password')
        user = UserRegistration.objects.all()
        serializer = UserRegistrationSerializer(user, many=True)
        for i in range(0,len(serializer.data)):
            for key, value in serializer.data[i].items():
                if(key == "User_Email" and value == email):
                    print(value)
                    userEmail = value
                    userPassword = serializer.data[i].get('Password')
                    make["email"] = serializer.data[i].get('User_Email')
                    make["fullname"] = serializer.data[i].get('Full_Name')
                    make["city"] = serializer.data[i].get('City')
                    make["contact"] = serializer.data[i].get('Contact_Number')
        if(userEmail == email and userPassword == password):
            return Response(make, status=status.HTTP_200_OK)
        elif(userEmail != email or userPassword != password):
            return Response({'Message':'No data found'}, status=status.HTTP_401_UNAUTHORIZED)

class MechanicByEmail(GenericViewSet):
    queryset = MechanicRegistration.objects.all()
    serializer_class = MechanicRegistrationSerializer

    def create(self, request):
        serializer = MechanicRegistrationSerializer(data=request.data)
        userEmail = ""
        userPassword = ""
        make = {}
        email = request.data.get('Mechanic_Email')
        password = request.data.get('Password')
        user = MechanicRegistration.objects.all()
        serializer = MechanicRegistrationSerializer(user, many=True)
        for i in range(0,len(serializer.data)):
            for key, value in serializer.data[i].items():
                if(key == "Mechanic_Email" and value == email):
                    print(value)
                    userEmail = value
                    userPassword = serializer.data[i].get('Password')
                    make["email"] = serializer.data[i].get('Mechanic_Email')
                    make["fullname"] = serializer.data[i].get('Full_Name')
                    make["city"] = serializer.data[i].get('City')
                    make["contact"] = serializer.data[i].get('Contact_Number')
                    make["services"] = serializer.data[i].get('Services')
        if(userEmail == email and userPassword == password):
            return Response(make, status=status.HTTP_200_OK)
        elif(userEmail != email or userPassword != password):
            return Response({'Message':'No data found'}, status=status.HTTP_401_UNAUTHORIZED)



class MechanicList(GenericViewSet):
    queryset = MechanicRegistration.objects.all()
    serializer_class = MechanicRegistrationSerializer

    def create(self, request):
        serializer = MechanicRegistrationSerializer(data=request.data)
        MechanicsOnServices = {}
        requestedServices = request.data.get('Services')
        user = MechanicRegistration.objects.all()
        serializer = MechanicRegistrationSerializer(user, many=True)
        for i in range(0,len(serializer.data)):
            for key, value in serializer.data[i].items():
                if(key == "Services" and value == requestedServices):
                    MechanicsOnServices["fullname"] = serializer.data[i].get("Full_Name");
        
        print(MechanicsOnServices)
        if(MechanicsOnServices):
            return Response(json.dumps(serializer.data),status=status.HTTP_200_OK)
        else:
            return Response({'Message':'No Services'}, status=status.HTTP_503_SERVICE_UNAVAILABLE)

class DetailUpdate(GenericViewSet):
    queryset = Detail.objects.all()
    serializer_class = DetailSerializer

    def retrieve(self, request, pk=None,):
        id = pk
        if id is not None:
            Workshop = Detail.objects.get(Workshop_Name=id)
            serializer = DetailSerializer(Workshop)
            return Response(serializer.data)

    def create(self, request):
        serializer = DetailSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response({'Message':'Workshop Created'}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def list(self, request):
        user = Detail.objects.all()
        serializer = DetailSerializer(user, many=True)
        return Response(serializer.data)

    def update(self, request, pk=None):
        id = pk
        Workshop =  Detail.objects.get(Workshop_Name=id)
        serializer = DetailSerializer(Workshop, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response({'Message':'Workshop Updated'}, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)    

    def partial_update(self, request, pk=None):
        id = pk
        Workshop =  Detail.objects.get(Workshop_Name=id)
        serializer = DetailSerializer(Workshop, data=request.data, partial = True)
        if serializer.is_valid():
            serializer.save()
            return Response({'Message':'Partial Data Updated'}, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)    

    def destroy(self, request, pk):
        id = pk
        Workshop = Detail.objects.get(Workshop_Name=id)
        Workshop.delete()
        return Response({'Message':'Data Deleted'}, status=status.HTTP_200_OK)


class CarDetailUpdate(GenericViewSet):
    queryset = CarDetail.objects.all()
    serializer_class = CarDetailSerializer

    def retrieve(self, request, pk=None,):
        id = pk
        if id is not None:
            Car = CarDetail.objects.get(Car_Model=id)
            serializer = CarDetailSerializer(Car)
            return Response(serializer.data)

    def create(self, request):
        serializer = CarDetailSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response({'Message':'Car Created'}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def list(self, request):
        user = CarDetail.objects.all()
        serializer = CarDetailSerializer(user, many=True)
        return Response(serializer.data)

    def update(self, request, pk=None):
        id = pk
        Car =  CarDetail.objects.get(Car_Model=id)
        serializer = CarDetailSerializer(Car, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response({'Message':'Car Updated'}, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)    

    def partial_update(self, request, pk=None):
        id = pk
        Car =  CarDetail.objects.get(Car_Model=id)
        serializer = CarDetailSerializer(Car, data=request.data, partial = True)
        if serializer.is_valid():
            serializer.save()
            return Response({'Message':'Partial Data Updated'}, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)    

    def destroy(self, request, pk):
        id = pk
        Car = CarDetail.objects.get(Car_Model=id)
        Car.delete()
        return Response({'Message':'Data Deleted'}, status=status.HTTP_200_OK)