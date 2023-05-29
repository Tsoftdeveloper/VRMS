import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Mechanic/MechanicProfileScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'GarageCard.dart';

class SaveWorkshopDetails extends StatefulWidget {
  const SaveWorkshopDetails({Key? key}) : super(key: key);

  @override
  State<SaveWorkshopDetails> createState() => _SaveWorkshopDetailsState();
}


class _SaveWorkshopDetailsState extends State<SaveWorkshopDetails> {
  String w_location = "", w_contact = "", w_services = "", w_name = "";
  String s_location = "", s_contact = "", s_services = "", s_name = "";
  TextEditingController workshop = new TextEditingController();
  TextEditingController storedname = new TextEditingController();
  TextEditingController storedlocation = new TextEditingController();
  TextEditingController storedcontact = new TextEditingController();
  TextEditingController storedservices = new TextEditingController();

  bool show = false;
  bool showSave = true;
  bool showUpdate = false;
  final _formKey = GlobalKey<FormState>();


  Future updateDetails() async {

    final _prefs = await SharedPreferences.getInstance();
    String? email = "";
    if (_prefs.getString("email") != null){
      email = _prefs.getString("email");
    }

    var headers = {'Content-Type': 'application/json'};

    var request = http.Request(
        'PUT', Uri.parse('http://127.0.0.1:8000/UpdateWorkshopDetails/'+storedname.text+"/"));
    request.body = json.encode({
      "Workshop_Name": storedname.text,
      "Workshop_Location": storedlocation.text,
      "Workshop_Phone": storedcontact.text,
      "Workshop_Services": storedservices.text
    });

    request.headers.addAll(headers);

    final response = await request.send();
    final respStr = await response.stream.bytesToString();
    final decoded = jsonDecode(respStr);

    if (response.statusCode == 200) {
      print("Updated...");
      if (decoded["Message"] != null) {
        if (decoded["Message"] == "Workshop Updated") {

          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: Text("Workshop Updated Successfully."),
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
    }else{

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Text("Couldn't update."),
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

  Future getData() async {
    var headers = {'Content-Type': 'application/json'};

    String url = 'http://127.0.0.1:8000/UpdateWorkshopDetails/'+workshop.text+"/";
    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    if (response.statusCode == 200) {

      print(response.body);
      print("here");
      final decode = json.decode(response.body);
      if (decode != null) {
        setState(() {
          show = true;
          showSave = false;
          showUpdate = true;
        });
        setState(() {
          s_name = decode["Workshop_Name"].toString();
          storedname.text = s_name;
          s_location = decode["Workshop_Location"].toString();
          storedlocation.text = s_location;
          s_contact = decode["Workshop_Phone"].toString();
          storedcontact.text = s_contact;
          s_services = decode["Workshop_Services"].toString();
          storedservices.text = s_services;

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

  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();

      if (isValid == true) {
        saveDetails();

    }
  }
  Future saveDetails() async {

    final _prefs = await SharedPreferences.getInstance();
    String? email = "";
    if (_prefs.getString("email") != null){
      email = _prefs.getString("email");
    }

    var headers = {'Content-Type': 'application/json'};

    var request = http.Request(
        'POST', Uri.parse('http://127.0.0.1:8000/UpdateWorkshopDetails/'));
    request.body = json.encode({
      "Workshop_Name": w_name,
      "Workshop_Location": w_location,
      "Workshop_Phone": w_contact,
      "Workshop_Services": w_services
    });

    print(request.body);
    request.headers.addAll(headers);

    final response = await request.send();
    final respStr = await response.stream.bytesToString();
    final decoded = jsonDecode(respStr);
    print(decoded);

    if (response.statusCode == 200) {
      if (decoded["Message"] != null) {
        if (decoded["Message"] == "Workshop Created") {
          setState(() {
            showSave = false;
            showUpdate = true;
          });

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
    }else{
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Text("Data already exists."),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Workshop Details"),
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
                        child: const Image(
                            image: NetworkImage(
                                "https://cdn.pixabay.com/photo/2014/05/18/19/13/toyota-347288__480.jpg"))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.brown),
                      child: const Icon(LineAwesomeIcons.camera,
                          color: Colors.black, size: 20),
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
                      controller: storedname,
                      decoration: const InputDecoration(

                          label: Text("Garage Name: "),
                          prefixIcon: Icon(Icons.drive_file_rename_outline)),
                      onChanged: (value) => w_name = value,
                    ),
                    TextFormField(
                      controller: storedlocation,
                      decoration: const InputDecoration(
                          label: Text("Location: "),
                          prefixIcon: Icon(Icons.pin_drop)),
                      onChanged: (value) => w_location = value,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: storedcontact,
                      decoration: const InputDecoration(
                          label: Text("Contact: "),
                          prefixIcon: Icon(LineAwesomeIcons.phone)),
                      onChanged: (value) => w_contact = value,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: storedservices,
                      decoration: const InputDecoration(
                          label: Text("Services:"),
                          prefixIcon: Icon(LineAwesomeIcons.tools)),
                      onChanged: (value) => w_services = value,
                    ),
                    SizedBox(height: 40),
                    Visibility(
                      visible: showSave,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        child: ElevatedButton(
                          onPressed: () {
                            _trySubmitForm();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown,
                              side: BorderSide.none,
                              shape: const StadiumBorder()),
                          child: const Text("Save",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),

                    Visibility(
                      visible: showUpdate,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        child: ElevatedButton(
                          onPressed: () {
                            updateDetails();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown,
                              side: BorderSide.none,
                              shape: const StadiumBorder()),
                          child: const Text("Update",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),

                    SizedBox( width: MediaQuery.of(context).size.width/2,
                      height: 40,),

                    TextFormField(
                      controller: workshop,
                      decoration: InputDecoration(
                        label: Text("Enter Your Workshop Name: "),
                      ),
                    ),
                    SizedBox( width: MediaQuery.of(context).size.width/2,
                      height: 40,),
                    ElevatedButton(
                      onPressed: () {
                        getData();

                      },

                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                          side: BorderSide.none,
                          shape: const StadiumBorder()),
                      child: const Text("Display",
                          style: TextStyle(color: Colors.white)),
                    ),

                    // -- Created Date and Delete Button
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Visibility(
                visible: show,
                child: Center(
                  child: GarageCard(
                      garage: Garage(
                        name: s_name,
                        location: s_location,
                        phoneNumber: s_contact,
                        services: s_services,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
