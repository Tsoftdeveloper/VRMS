
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/CarOwner/Dashboard.dart';
import 'package:untitled/CarOwner/Notifications.dart';
import 'package:untitled/CarOwner/ProfileScreen.dart';

class NotifyBottomNavbar extends StatefulWidget {
  const NotifyBottomNavbar({Key? key}) : super(key: key);


  @override
  _NotifyBottomNavbarState createState() {
    return _NotifyBottomNavbarState();
  }
}

class _NotifyBottomNavbarState extends State<NotifyBottomNavbar> {

  List _screens = [Dashboard(), Notifications(), ProfileScreen()];

  int _currentIndex = 1;
  void _updateIndex(int value) {
    setState(() {
      _currentIndex = value;
    });

    if (value == 0) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const Dashboard(

          ),
        ),
      );
    } else if (value == 1) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const Notifications(),
        ),
      );
    }else if (value == 2) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        ),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
          label: "Notifications",
          icon: Icon(
            Icons.notifications,
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
