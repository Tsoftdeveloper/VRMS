import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/SignupuserDetails.dart';


class SignupRole extends StatefulWidget {
  const SignupRole({Key? key}) : super(key: key);

  @override
  State<SignupRole> createState() => _SignupRoleState();
}

class _SignupRoleState extends State<SignupRole> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String radioItem = '';

  Future<void> next() async {
    final bool? isValid = _formKey.currentState?.validate();
    final _prefs = await SharedPreferences.getInstance();
    if (radioItem != '') {

      _prefs.setString('role', radioItem);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const SignupuserDetails(),
        ),
      );
    }else{
       showDialog(context: context, builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Please select a role'),
        );
    });
  }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Repair Management System',
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurpleAccent,

        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        body: Center(
          child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Text(
                      'REGISTER',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  RadioListTile(
                    groupValue: radioItem,
                    selectedTileColor: Colors.white,
                    activeColor: Colors.white,
                    title: Text(
                      'Car Owner',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
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

                    groupValue: radioItem,
                    selectedTileColor: Colors.white,
                    activeColor: Colors.white,
                    title: Text(
                      'Mechanic',
                      style: TextStyle(
                        fontSize: 15,
                          color: Colors.white
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
                    height: 80,
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 3.0,
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: const Text('Next '),
                      onPressed: next,
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}