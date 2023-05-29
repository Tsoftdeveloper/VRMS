import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:untitled/CarOwner/Dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'Login.dart';
import 'Mechanic/MechanicDashboard.dart';

class setPassword extends StatefulWidget {
  const setPassword({Key? key}) : super(key: key);

  @override
  State<setPassword> createState() => _setPasswordState();
}

class _setPasswordState extends State<setPassword> {
  bool _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController password = new TextEditingController();
  TextEditingController confirmpassword = new TextEditingController();
  String role = "",
      firstname = "",
      lastname = "",
      email = "",
      cnic = "",
      contact = "",
      service = "",
      city = "";

  @override
  void initState() {
    super.initState();
    _sharedPref();
  }

  Future<void> _sharedPref() async {
    final _prefs = await SharedPreferences.getInstance();
    setState(() {
      firstname = (_prefs.getString('firstname') ?? '');
      lastname = (_prefs.getString('lastname') ?? '');
      email = (_prefs.getString('email') ?? '');
      cnic = (_prefs.getString('cnic') ?? '');
      contact = (_prefs.getString('contact') ?? '');
      city = (_prefs.getString('city') ?? '');
      role = (_prefs.getString('role') ?? '');
      service = (_prefs.getString('requestedService') ?? '');
    });
  }

  void validate() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      buttonPressed();
    } else {
      print("Is Valid false");
    }
  }

  Future<String> buttonPressed() async {
    String API = "", email_ = "";
    List mesg = [];
    if (role == 'Car Owner') {
      API = "Userapi";
    } else {
      API = "Mechanicapi";
    }
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('http://127.0.0.1:8000/' + API + '/'));

    if ((role == 'Car Owner')) {
      request.body = json.encode({
        "Username": firstname,
        "Password": password.text,
        "User_Email": email.trim(),
        "Full_Name": firstname + " " + lastname,
        "CNIC_Number": cnic.trim(),
        "City": city.trim(),
        "Contact_Number": contact.trim()
      });
    } else {
      request.body = json.encode({
        "Username": firstname,
        "Password": password.text,
        "Mechanic_Email": email.trim(),
        "Full_Name": firstname + " " + lastname,
        "CNIC_Number": cnic.trim(),
        "City": city.trim(),
        "Contact_Number": contact.trim(),
        "Services": service.toLowerCase(),
      });
    }

    print(request.body);
    request.headers.addAll(headers);

    final response = await request.send();
    final responseString = await response.stream.bytesToString();
    final decoded = jsonDecode(responseString);
    print(decoded.length);
    if (decoded["Message"] != null) {
      print("Success");
      print(decoded["Message"]);
    } else {
      if (decoded["Username"] != null) {
        mesg.add(decoded["Username"]);
        print(decoded["Username"]);
      }
      if (decoded["User_Email"] != null) {
        mesg.add(decoded["User_Email"]);
        print(decoded["User_Email"]);
      }
      if (decoded["Full_Name"] != null) {
        mesg.add(decoded["Full_Name"]);
        print(decoded["Full_Name"]);
      }

      if (decoded["CNIC_Number"] != null) {
        mesg.add(decoded["CNIC_Number"]);
        print(decoded["CNIC_Number"]);
      }
      if (decoded["Contact_Number"] != null) {
        mesg.add(decoded["Contact_Number"]);
        print(decoded["Contact_Number"]);
      }
      if (role != "Car Owner" && decoded["Mechanic_Email"] != null) {
        mesg.add(decoded["Mechanic_Email"]);
        print(decoded["Mechanic_Email"]);
      }
    }
    print("List: " + mesg.toString());

    print(response.statusCode);

    if (response.statusCode == 400 || mesg == null) {
      String? reason = response.reasonPhrase;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Text("Sign Up Failed!"),
                content: Text(
                    mesg.join(",").replaceAll("[", "").replaceAll("]", "") +
                        '. Please try again.'),
                actions: <Widget>[
                  TextButton(
                    child: new Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop(
                      );
                    },
                  ),
                  TextButton(
                    child: new Text('Try Again'),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                      );
                    },
                  )
                ]);
          });
    } else {
      final _prefs = await SharedPreferences.getInstance();

      setState(() {
        if (_prefs != null) {
          _prefs.remove('email');
          _prefs.remove('userdata');
          _prefs.clear();
        }
          _prefs.setString('email', email);
          print( _prefs.getString('email'));
          _prefs.setString('userdata', jsonEncode(mesg));
          if (role == "Car Owner") {

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Dashboard(),
              ),
            );
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const MechanicDashboard(),
              ),
            );
          }

      });

    }
    return "";
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurpleAccent,
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: Text(
                    'REGISTER',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  child: Text(
                    'Set Password',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: password,
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2.0),
                    ),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Please enter a password';
                    } else if (val.length < 5) {
                      return 'This password is too short. Try a longer password.';
                    } else {
                      print("password saved.");
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: confirmpassword,
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2.0),
                    ),
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Please re-enter your password';
                    }
                  },
                ),
              ),
              Container(
                height: 80,
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 3.0,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text('Submit '),
                  onPressed: () {
                    print("pass: " + password.text);
                    print("pass: " + confirmpassword.text);

                    if (password.text == confirmpassword.text) {
                      print("matched");
                      buttonPressed();
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                title: Text("Sign Up Failed!"),
                                content: Text(
                                    'Please enter same password in both fields.'),
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
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
