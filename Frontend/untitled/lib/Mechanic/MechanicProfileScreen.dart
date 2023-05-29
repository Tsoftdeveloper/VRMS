import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Login.dart';
import 'package:untitled/Mechanic/MechanicDashboard.dart';
import 'package:untitled/Mechanic/SaveWorkshopDetails.dart';
import 'package:untitled/CarOwner/SaveCarDetails.dart';

import 'MProfileMenuWidget.dart';
import 'MechanicPayment.dart';
import 'SavePersonalDetails.dart';

class MechanicProfileScreen extends StatefulWidget {
  const MechanicProfileScreen({Key? key}) : super(key: key);

  @override
  State<MechanicProfileScreen> createState() => _MechanicProfileScreenState();
}

class _MechanicProfileScreenState extends State<MechanicProfileScreen> {
  String fullname="";
  String role = "", w_name="", m_exp = "", m_desc = "" , m_contact = "", m_name = "";

  @override
  void initState() {
    super.initState();
    _sharedPref();
  }

  Future<void> _sharedPref() async {
    final _prefs = await SharedPreferences.getInstance();
    setState(() {
      fullname = (_prefs.getString('email') ?? '');
      role = (_prefs.getString('role') ?? '');
      w_name = (_prefs.getString('w_name') ?? '');
      m_name = (_prefs.getString('m_name') ?? '');
      m_exp = (_prefs.getString('m_exp') ?? '');
      m_desc = (_prefs.getString('m_desc') ?? '');
      m_contact = (_prefs.getString('m_contact') ?? '');
      if (m_name.isNotEmpty) {
        fullname = m_name;
      }
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
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100), child: const Image(image: NetworkImage("https://xsgames.co/randomusers/assets/avatars/male/46.jpg"))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.brown),
                      child: const Icon(
                        LineAwesomeIcons.alternate_pencil,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(fullname, style: Theme.of(context).textTheme.headline6),
              Text("Mechanic", style: Theme.of(context).textTheme.bodyText2),
              Text("$w_name", style: TextStyle(color: Colors.deepPurple),),
              const SizedBox(height: 20),

              /// -- BUTTON
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => {},
                  style: ElevatedButton.styleFrom(
                    elevation: 3.0,
                      backgroundColor: Colors.deepPurpleAccent, side: BorderSide.none, shape: const StadiumBorder()),
                  child: const Text("Profile", style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              /// -- MENU
              MProfileMenuWidget(title: "View Dashboard", icon: Icons.home, onPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MechanicDashboard(),
                  ),
                );
              }),
              MProfileMenuWidget(title: "Workshop Details", icon: Icons.car_repair_outlined, onPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SaveWorkshopDetails(),
                  ),
                );
              }),
              MProfileMenuWidget(title: "Save Personal Details", icon: Icons.settings, onPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SavePersonalDetails(),
                  ),
                );
              }),
              const Divider(),
              const SizedBox(height: 10),
              MProfileMenuWidget(
                  title: "Payments",
                  icon: LineAwesomeIcons.money_check,
                   onPress: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MechanicPayment(),
                      ),
                    );
                  }),
              const Divider(),
              const SizedBox(height: 10),
              MProfileMenuWidget(
                  title: "Logout",
                  icon: LineAwesomeIcons.alternate_sign_out,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {
                    logout();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

