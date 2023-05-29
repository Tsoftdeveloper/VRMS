import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Login.dart';
import 'package:untitled/CarOwner/SaveCarDetails.dart';
import 'package:untitled/widget/BottomNavBar.dart';

import '../widget/ProfileBottomNavBar.dart';
import 'Dashboard.dart';
import 'Payment.dart';
import 'ProfileMenuWidget.dart';
import 'TrackStatus.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String fullname="";
  String role = "";
  String email = "";

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
    });
  }

  Future<void> logout() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
  @override
  Widget build(BuildContext context) {


    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurpleAccent,
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Profile"),
        ),
        bottomNavigationBar: ProfileBottomNavbar(),
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
                          borderRadius: BorderRadius.circular(100), child: const Image(image: NetworkImage("https://www.shareicon.net/data/512x512/2016/07/26/802043_man_512x512.png"))),
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
                Text("Car Owner", style: Theme.of(context).textTheme.bodyText2),
                const SizedBox(height: 20),

                /// -- BUTTON
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
                const Divider(),
                const SizedBox(height: 10),

                /// -- MENU
                ProfileMenuWidget(title: "View Dashboard", icon: Icons.home, onPress: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const Dashboard(),
                                  ),
                                );
                }),
                ProfileMenuWidget(title: "Car Details", icon: Icons.car_repair_outlined, onPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const UpdateProfileScreen(),
                    ),
                  );
                }),
                const Divider(),
                const SizedBox(height: 10),
                ProfileMenuWidget(title: "Track Status", icon: Icons.battery_full_sharp, onPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const TrackStatus(),
                    ),
                  );
                }),

                const Divider(),
                const SizedBox(height: 10),
                ProfileMenuWidget(title: "Payments", icon: Icons.money, onPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Payment(),
                    ),
                  );
                }),
                const Divider(),
                const SizedBox(height: 10),
                ProfileMenuWidget(
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
      ),
    );
  }
}

