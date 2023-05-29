
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'CarCard.dart';
import 'ProfileScreen.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final controller = "";
  String carmake = "";
  bool showSave = true;
  bool showUpdate = false;
  bool show = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController carId = new TextEditingController();
  TextEditingController company = new TextEditingController();
  TextEditingController model = new TextEditingController();
  TextEditingController etype = new TextEditingController();
  TextEditingController ecpacity = new TextEditingController();
  TextEditingController milage = new TextEditingController();

  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();

    if (isValid == true) {
      saveDetails();

    }
  }

  updateData() async{

    final _prefs = await SharedPreferences.getInstance();
    String? email = "";
    if (_prefs.getString("email") != null){
      email = _prefs.getString("email");
    }

    var headers = {'Content-Type': 'application/json'};

    var request =
    http.Request('PUT', Uri.parse('http://127.0.0.1:8000/CarDetails/'+carId.text+"/"));
    request.body = json.encode({

      "Car_Company": company.text,
      "Car_Model": model.text,
      "Engine_Type": etype.text,
      "Engine_Capacity": ecpacity.text,
      "Mileage": milage.text

    });

    print(request.body);
    request.headers.addAll(headers);

    final response = await request.send();
    final respStr = await response.stream.bytesToString();
    final decoded = jsonDecode(respStr);
    print(decoded);

    if (response.statusCode == 200){
      if (decoded["Message"] != null) {
        if (decoded["Message"] == "Car Updated") {

          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: Text("Updated Successfully."),
                    actions: <Widget>[
                      TextButton(
                        child: new Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ]);
              });
        }else{

          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: Text("Couldn't Update."),
                    actions: <Widget>[
                      TextButton(
                        child: new Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ]);
              });
        }
      }
    }



  }


  Future getData() async {
    var headers = {'Content-Type': 'application/json'};

    String url = 'http://127.0.0.1:8000/CarDetails/'+carId.text+"/";
    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    if (response.statusCode == 200) {

      print(response.body);
      print("here");
      final decode = json.decode(response.body);
      if (decode != null) {

        setState(() {
          showSave = false;
          showUpdate = true;
          company.text = decode["Car_Company"].toString();

          model.text = decode["Car_Model"].toString();

          etype.text = decode["Engine_Type"].toString();

          ecpacity.text = decode["Engine_Capacity"].toString();

          milage.text = decode["Mileage"].toString();

        });

      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Text("No data found."),
                actions: <Widget>[
                  TextButton(
                    child: new Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ]);
          });
      // Handle error status code
      print('Request failed with status: ${response.statusCode}.');
    }
  }


  Future saveDetails() async{

    final _prefs = await SharedPreferences.getInstance();
    String? email = "";
    if (_prefs.getString("email") != null){
      email = _prefs.getString("email");
    }

    var headers = {'Content-Type': 'application/json'};

    var request =
    http.Request('POST', Uri.parse('http://127.0.0.1:8000/CarDetails/'));
    request.body = json.encode({

        "Car_Company": company.text,
        "Car_Model": model.text,
        "Engine_Type": etype.text,
        "Engine_Capacity": ecpacity.text,
        "Mileage": milage.text

    });

    print(request.body);
    request.headers.addAll(headers);

    final response = await request.send();
    final respStr = await response.stream.bytesToString();
    final decoded = jsonDecode(respStr);
    print(decoded);

    if (response.statusCode == 200){
    if (decoded["Message"] != null) {
      if (decoded["Message"] == "Car Created") {

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: Text("Saved Successfully."),
                  actions: <Widget>[
                    TextButton(
                      child: new Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ]);
            });
      }
    }
    }
    else{
      print("Couldn't Save..");
      print("User Created");
    }


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Car Details"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              // -- IMAGE with ICON
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(image: NetworkImage("https://cdn.pixabay.com/photo/2014/05/18/19/13/toyota-347288__480.jpg"))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.brown),
                      child: const Icon(LineAwesomeIcons.camera, color: Colors.black, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),

              // -- Form Fields
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: company,
                      decoration: const InputDecoration(
                        hintText: "Company of Car",
                          label: Text("Make"), prefixIcon: Icon(LineAwesomeIcons.building)),
                      onChanged: (value) => carmake = value,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: model,
                      decoration: const InputDecoration(
                          label: Text("Assign a Unique Car ID:"), prefixIcon: Icon(LineAwesomeIcons.key)),

                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: etype,
                      decoration: const InputDecoration(
                          label: Text("Engine Type"), prefixIcon: Icon(LineAwesomeIcons.car)),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: ecpacity,
                      decoration: InputDecoration(
                        label: const Text("Engine Capacity"),
                        prefixIcon: const Icon(Icons.car_repair_outlined),

                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: milage,
                      decoration: InputDecoration(
                        label: const Text("Milage"),
                        prefixIcon: const Icon(Icons.car_repair_outlined),

                      ),
                    ),
                    // -- Form Submit Button
                    SizedBox(height: 40),
                    Visibility(
                      visible: showSave,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        child: ElevatedButton(
                          onPressed: (){
                            _trySubmitForm();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown,
                              side: BorderSide.none,
                              shape: const StadiumBorder()),
                          child: const Text("Save", style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Visibility(
                      visible: showUpdate,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        child: ElevatedButton(
                          onPressed: (){
                            updateData();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown,
                              side: BorderSide.none,
                              shape: const StadiumBorder()),
                          child: const Text("Update", style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    TextFormField(
                      controller: carId,
                      decoration: InputDecoration(
                        label: const Text("Enter your Unqiue Car ID: "),
                        prefixIcon: const Icon(Icons.car_repair_outlined),

                      ),
                    ),
                    SizedBox(height: 40),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/2,
                      child: ElevatedButton(
                        onPressed: (){
                          getData();
                          setState(() {
                            show = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurpleAccent,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text("Display", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    // -- Created Date and Delete Button

                  ],
                ),
              ),

              SizedBox(
                height: 20,
              ),

              Visibility(
                visible: show,
                child: Center(
                  child: CarCard(car: Car(
                    company: company.text,
                    model: model.text,
                    engineType: etype.text,
                    engineCapacity: ecpacity.text,
                    milage: milage.text
                  ),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}