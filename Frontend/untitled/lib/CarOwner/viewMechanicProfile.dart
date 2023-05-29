import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Login.dart';
import 'package:untitled/CarOwner/SaveCarDetails.dart';

import 'Dashboard.dart';
import 'ProfileMenuWidget.dart';

class viewMechanicProfile extends StatefulWidget {
  const viewMechanicProfile({Key? key}) : super(key: key);

  @override
  State<viewMechanicProfile> createState() => _viewMechanicProfileState();
}

class _viewMechanicProfileState extends State<viewMechanicProfile> {
  String fullname="";
  String role = "";
  Map emap = new Map();

  @override
  void initState() {
    super.initState();
    _sharedPref();
  }

  Future<void> _sharedPref() async {
    final _prefs = await SharedPreferences.getInstance();
    setState(() {
      emap = json.decode((_prefs.getString('viewuser') ?? ''));
      print(emap);
    });
  }

  Future<void> logout() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
  @override
  Widget build(BuildContext context) {


    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
             /// -- IMAGE
              Stack(
                children: [
                  SizedBox(
                    width: 90,
                    height: 100,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100), child: Image(image: NetworkImage(emap["image"].toString()))),
                  ),

                ],
              ),
              const SizedBox(height: 10),
              Text(emap["fullname"].toString(), style: Theme.of(context).textTheme.headline4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(emap["city"].toString() + " | ", style: Theme.of(context).textTheme.bodyText2),
                  Text(emap["rating"].toString() ),
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent, side: BorderSide.none, shape: const StadiumBorder()),
                  child: const Text("Profile", style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 30),
              Text('Email: ' +emap["email"].toString(), style: Theme.of(context).textTheme.bodyText2),
              const SizedBox(height: 10),
              const Divider(),
              Text('Services: '),
              Text(emap["services"].toString(), style: TextStyle(color:Colors.deepPurpleAccent) ),
              const SizedBox(height: 10),

              /// -- BUTTON

              const SizedBox(height: 10),
              const Divider(),

              // Padding(
              //   padding: EdgeInsets.only(top: 20, bottom: 10),
              //   child: ElevatedButton(
              //       onPressed: () {
              //         showDialog(
              //             context: context,
              //             builder: (BuildContext context) {
              //               return AlertDialog(
              //                   title:  Text("Your request has been sent to "+emap["fullname"].toString()+"."),
              //                   content: Text('Please wait until he accepts.'),
              //                   actions: <Widget> [
              //                     TextButton(
              //                       child: new Text('OK'),
              //                       onPressed: () async {
              //                         final _prefs = await SharedPreferences.getInstance();
              //
              //                         setState(() {
              //                           if (emap["id"] == "1") {
              //                             _prefs.setString('reqBit', "1"); // 1 means request sent to Mech ID 1
              //                           }else if (emap["id"] == "2"){
              //                             _prefs.setString('reqBit', "2");
              //                           }else  if (emap["id"] == "3"){
              //                             _prefs.setString('reqBit', "3");
              //                           }
              //                         });
              //                         Navigator.of(context).pop();
              //                       },
              //                     )
              //                   ]
              //               );
              //             });
              //       },
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: Colors.brown,
              //         elevation: 3.0,
              //         minimumSize: const Size.fromHeight(50),
              //
              //       ),
              //       child: Text('Request', style:TextStyle(color:Colors.white))),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

