import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Mechanic/MechanicProfileScreen.dart';

import '../CarOwner/UserCard.dart';

class SavePersonalDetails extends StatefulWidget {
  const SavePersonalDetails({Key? key}) : super(key: key);

  @override
  State<SavePersonalDetails> createState() => _SavePersonalDetailsState();
}

class _SavePersonalDetailsState extends State<SavePersonalDetails> {
  String m_name="", m_contact="", m_exp = "", m_desc = "";
  final _formKey = GlobalKey<FormState>();


  Future saveDetails() async{


    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Saved Successfully."),
              actions: <Widget>[
                TextButton(
                  child: new Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(
                      MaterialPageRoute(
                        builder: (context) => const MechanicProfileScreen(),
                      ),
                    );
                  },
                )
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Details"),
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
                        child: const Image(image: NetworkImage("https://xsgames.co/randomusers/assets/avatars/male/46.jpg"))),
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
                    // TextFormField(
                    //   decoration: const InputDecoration(
                    //       label: Text("Name: "), prefixIcon: Icon(Icons.drive_file_rename_outline)),
                    //   onChanged: (value) => m_name = value,
                    // ),
                    TextFormField(
                      decoration: const InputDecoration(
                          label: Text("Description: "), prefixIcon: Icon(Icons.tag)),
                      onChanged: (value) => m_desc = value,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                          label: Text("Contact: "), prefixIcon: Icon(LineAwesomeIcons.phone)),
                      onChanged: (value) => m_contact = value,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                          label: Text("Experience:"), prefixIcon: Icon(LineAwesomeIcons.tools)),
                      onChanged: (value) => m_exp = value,
                    ),
                    SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (){
                          saveDetails();

                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text("Save", style: TextStyle(color: Colors.white)),
                      ),
                    ),

                    // -- Created Date and Delete Button

                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),

              Center(
                child: UserCard(user: User(
                  name: "Danny",
                  contact: "danny@gmail.com",
                  experience: "5 years",
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}