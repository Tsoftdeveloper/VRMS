import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/serPassword.dart';
import 'package:untitled/widget/Dropdownlist.dart';

class SignupuserDetails extends StatefulWidget {
  const SignupuserDetails({Key? key}) : super(key: key);

  @override
  State<SignupuserDetails> createState() => _SignupuserDetailsState();
}

class _SignupuserDetailsState extends State<SignupuserDetails> {
  // This widget is the root of your application.
  final _formKey = GlobalKey<FormState>();
  bool show = false;
  static final RegExp nameRegExp = RegExp('[a-zA-Z]');
  static final RegExp numberRegExp = RegExp(r'\d');

  String firstname = "";
  String password = "";
  String role = "";
  String lastname = "";
  String cnic = "";
  String city = "";
  String contact = "";
  String email = "";
  String fullname = "";

  @override
  void initState() {
    super.initState();
    _sharedPref();
  }

  Future<void> _sharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      role = (prefs.getString('role') ?? '');
      if (role != 'Car Owner'){
        show = true;
      }
    });
  }

  Future<void> next() async {
    final bool? isValid = _formKey.currentState?.validate();
    final _prefs = await SharedPreferences.getInstance();

    setState(() {
      _prefs.setString('firstname', firstname);
      _prefs.setString('lastname', lastname);
      _prefs.setString('email', email);
      _prefs.setString('cnic', cnic);
      _prefs.setString('contact', contact);
      _prefs.setString('city', city);
      _prefs.setString('role', role);
    });
    if (isValid == true) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const setPassword(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurpleAccent,

        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
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
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    child: Text(
                      'Set up Profile as $role',
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
                      style: TextStyle(
                          color:Colors.white
                      ),
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color:Colors.white),
                        ),
                        focusedBorder:UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2.0),
                        ),
                        labelText: 'Enter First Name ',
                        labelStyle: TextStyle(color:Colors.white),
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Please enter first name';
                        } else if (val != null &&
                            val.trim().isNotEmpty &&
                            val.contains(numberRegExp) == false) {
                          setState(() {
                            firstname = val;
                          });
                        } else {
                          return 'Please enter a valid name';
                        }
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    style: TextStyle(
                        color:Colors.white
                    ),
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color:Colors.white),
                      ),
                      focusedBorder:UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      labelText: 'Enter Last Name ',
                      labelStyle: TextStyle(color:Colors.white),
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Please enter last name';
                      } else if (val != null &&
                          val.trim().isNotEmpty &&
                          val.contains(numberRegExp) == false) {
                        setState(() {
                          lastname = val;
                        });
                      } else {
                        return 'Please enter a valid name';
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))],
                    style: TextStyle(
                        color:Colors.white
                    ),
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color:Colors.white),
                      ),
                      focusedBorder:UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      labelText: 'Enter email ',
                      labelStyle: TextStyle(color:Colors.white),
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Please enter email';
                      }
                      if (val != null &&
                          val.trim().isNotEmpty &&
                          RegExp(r'\S+@\S+\.\S+').hasMatch(val)) {
                        setState(() {
                          email = val;
                        });
                      } else {
                        return 'Please enter a valid email address';
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9,-]')),FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s")),
                    LengthLimitingTextInputFormatter(15),],
                    style: TextStyle(
                        color:Colors.white
                    ),
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color:Colors.white),

                      ),
                      focusedBorder:UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      labelText: 'Enter CNIC Number',
                      labelStyle: TextStyle(color:Colors.white),
                      hintText: "Enter 15 digits with dashes",
                      hintStyle: TextStyle(color:Colors.white60),
                    ),
                      keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Please enter your CNIC number';
                      }
                      if (val != Null &&
                          val.trim().isNotEmpty &&
                          val.trim().length == 15) {
                        setState(() {
                          cnic = val;
                        });
                      } else {
                        return 'Please enter valid CNIC number. ';
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    style: TextStyle(
                        color:Colors.white
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Karachi, Islamabad, Lahore..',
                      hintStyle: TextStyle(color:Colors.white60),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color:Colors.white),
                      ),
                      focusedBorder:UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      labelText: 'Enter City',
                      labelStyle: TextStyle(color:Colors.white),
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Please enter your City';
                      } else {
                        setState(() {
                          city = val;
                        });
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(11)],
                    style: TextStyle(
                      color:Colors.white
                    ),
                    decoration: const InputDecoration(
                      hintText: '033XXXXXXX0',
                      hintStyle: TextStyle(color:Colors.white60),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color:Colors.white),
                      ),
                      focusedBorder:UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      labelText: 'Enter Contact Number',
                      labelStyle: TextStyle(color:Colors.white),
                    ),
                      keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Please enter your contact number';
                      }
                      if (val.trim().length == 11) {
                        setState(() {
                          contact = val;
                        });
                      } else {
                        return 'Please enter valid mobile number that begins with zero.';
                      }
                    },
                  ),
                ),
                Visibility(
                  visible: show,
                  child: Container(
                    color: Colors.white,
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Center(child: Dropdownlist(
                      )),
                    ),
                  ),
                ),
                Container(
                  height: 80,
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    child: const Text('Next '),
                    onPressed: next,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
