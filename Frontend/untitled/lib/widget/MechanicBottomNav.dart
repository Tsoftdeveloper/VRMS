import 'package:flutter/material.dart';
import 'package:untitled/CarOwner/Dashboard.dart';
import 'package:untitled/Mechanic/MechanicProfileScreen.dart';
import 'package:untitled/CarOwner/Notifications.dart';
import 'package:untitled/CarOwner/ProfileScreen.dart';

import '../Mechanic/MechanicDashboard.dart';

class MechanicBottomNav extends StatefulWidget {
  const MechanicBottomNav({Key? key}) : super(key: key);

  @override
  State<MechanicBottomNav> createState() => _MechanicBottomNavState();
}

class _MechanicBottomNavState extends State<MechanicBottomNav> {

  int _currentIndex = 0;
  List _screens = [Dashboard(), ProfileScreen()];


  void _updateIndex(int value) {
    setState(() {
      _currentIndex = value;
    });

    if (value == 0) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const MechanicDashboard(),
        ),
      );
    }else if (value == 1) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const MechanicProfileScreen(),
        ),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      onTap: _updateIndex,
      showSelectedLabels: true,
      selectedItemColor: Colors.deepPurpleAccent,
      selectedFontSize: 13,
      unselectedFontSize: 13,
      iconSize: 30,
      items: [
        BottomNavigationBarItem(
          label: "Dashboard",
          icon: Icon(
            Icons.home,
          ),
        ),

        BottomNavigationBarItem(
          label: "Profile",
          icon: Icon(Icons.account_circle_outlined ),
        ),
      ],
    );
  }
}
