import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/CarOwner/Dashboard.dart';
import 'package:http/http.dart' as http;
import 'CarOwner/SaveCarDetails.dart';
import 'Mechanic/MechanicDashboard.dart';
import 'SignupRole.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Car Repair Management System',
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurpleAccent,
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        body: LoginForm(),
      ),
    );
  }
}

// Create a Form widget.
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  String _password = '';
  String _userEmail = '';
  String radioItem = '';
  String errorMsg = "";

  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();
    if (radioItem.isNotEmpty) {
      if (isValid == true) {
        buttonPressed();
      }
    } else {
      error();
    }
  }

  Future error() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Please select role."),
              actions: <Widget>[
                TextButton(
                  child: new Text('OK'),
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
  }

  Future<void> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  Future<void> buttonPressed() async {
    try {
      String API = "";
      String email = "";
      List data = [];
      if (radioItem == "Car Owner") {
        API = "userdata";
        email = "User_Email";
      } else {
        API = "mechanicdata";
        email = "Mechanic_Email";
      }

      var headers = {'Content-Type': 'application/json'};

      var request =
          http.Request('POST', Uri.parse('http://127.0.0.1:8000/' + API + '/'));
      request.body = json.encode({
        "Username": "",
        "Password": _password,
        "$email": _userEmail,
        "Full_Name": "",
        "CNIC_Number": "",
        "City": "",
        "Contact_Number": "",
        "Services": ""
      });

      print(request.body);
      request.headers.addAll(headers);

      final response = await request.send();
      final respStr = await response.stream.bytesToString();
      final decoded = jsonDecode(respStr);
      print(decoded);


      if (decoded["Message"] != null) {
        data.add("User with this email or password donot exist.");
      } else {
        if (decoded["email"] != null) {
          data.add(decoded["email"]);
        }
        if (decoded["city"] != null) {
          data.add(decoded["city"]);
        }
        if (decoded["contact"] != null) {
          data.add(decoded["contact"]);
        }
        if (decoded["services"] != null) {
          data.add(decoded["services"]);
        }
      }
      print("data: "+data.toString());

      if (response.statusCode != 200 &&  decoded["Message"] != null){
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: Text("Login Unsuccessful."),
                  content: Text(data.toString()+'. Please try again?'),
                  actions: <Widget>[
                    TextButton(
                      child: new Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ]);
            });
      } else if (response.statusCode == 200) {
        final _prefs = await SharedPreferences.getInstance();

        setState(() {
          if (_prefs.getString('email') != null && _prefs.getString('userdata') != null && _prefs != null){
            _prefs.remove('email');
            _prefs.remove('userdata');
            _prefs.clear();
          }
            _prefs.setString('email', _userEmail);
            _prefs.setString('userdata', jsonEncode(data));

          if (radioItem == "Car Owner") {
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
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Text("Something went wrong!"),
                content:
                    Text('Please check your connection. Please try again.'),
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
    // Build a Form widget using the _formKey created above.
    return Container(
      child: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Text(
                      'AUTO CARE',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                      height: 150,
                      width: 150,
                      child: Image.network(
                          "https://cdn-icons-png.flaticon.com/512/1743/1743590.png")),
                  Container(
                    // padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  RadioListTile(
                    selectedTileColor: Colors.white,
                    activeColor: Colors.white,
                    groupValue: radioItem,
                    title: Text(
                      'Car Owner',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    value: 'Car Owner',
                    onChanged: (val) {
                      setState(() {
                        radioItem = val!;
                      });
                      debugPrint(val);
                    },
                  ),
                  RadioListTile(
                    selectedTileColor: Colors.white,
                    activeColor: Colors.white,
                    groupValue: radioItem,
                    title: Text(
                      'Mechanic',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    value: 'Mechanic',
                    onChanged: (val) {
                      setState(() {
                        radioItem = val!;
                      });
                      debugPrint(val);
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      autocorrect: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        icon: Icon(Icons.email_outlined, color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(90.0),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.white),
                        errorStyle: TextStyle(color: Colors.red[50]),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email address';
                        }
                        // Check if the entered email has the right format
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        // Return null if the entered email is valid
                        return null;
                      },
                      onChanged: (value) => _userEmail = value,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          obscureText: true, //to hide pass
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            icon: Icon(Icons.lock_outline_rounded,
                                color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(90.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.white),
                            errorStyle: TextStyle(color: Colors.red[50]),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'This field is required';
                            }

                            // Return null if the entered password is valid
                            return null;
                          },
                          onChanged: (value) => _password = value,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 80,
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 3.0,
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: const Text('Log In'),
                      onPressed: () {
                        _trySubmitForm();

                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) =>  UpdateProfileScreen(),
                        //   ),
                        // );
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SignupRole(),
                        ),
                      );
                    },
                    child: Text(
                      'Not a User? Sign Up.',
                      style: TextStyle(color: Colors.white60),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
