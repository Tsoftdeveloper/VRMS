import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/CarOwner/TrackStatus.dart';
import 'package:untitled/widget/BottomNavBar.dart';

import '../Models/Mechanic.dart';
import '../widget/NotifyBottomNavBar.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final _controller = TextEditingController();
  final items = [];
  String username = "";
  bool show = false;
  List reqBit = [];
  int itemCount = 0;



  @override
  void initState() {
    _sharedPref();
    super.initState();
    // Start a timer to add items to the list every second
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        // Increment the item count by 1 and update the ListView
        itemCount++;
      });
      // Stop the timer after all items have been added
      if (itemCount == items.length) {
        timer.cancel();
      }
    });

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _sharedPref() async {
    final _prefs = await SharedPreferences.getInstance();
    Mechanic obj = new Mechanic();
    setState(() {
      if (_prefs.getString('reqBit') != null) {
        reqBit = jsonDecode(_prefs.getString('reqBit')!);
        show = true;
      }
      print("Requested length: " +reqBit.length.toString());
      print("Requested: " +reqBit.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    double? scrolledUnderElevation;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurpleAccent,
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Notifications'),
          scrolledUnderElevation: scrolledUnderElevation,
        ),

        // backgroundColor: Colors.white,
        bottomNavigationBar: NotifyBottomNavbar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(
                        parent: NeverScrollableScrollPhysics()),
                    itemCount: reqBit.length,
                    itemBuilder: (context, index) {
                      final item = reqBit[index];
                      return Visibility(
                        visible: show,
                        child: Card(

                          color: Colors.white,
                          child: ListTile(
                            leading: Icon(
                              Icons.auto_fix_high,
                              color: Colors.brown,
                            ),
                            title: Text(reqBit[index]),
                            subtitle: Text(
                                'Your mechanic is ready to fix your car.'),
                            trailing: Text('In 10 - 15 mins'),
                            onTap:() {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const TrackStatus(),
                                 ),
                          );
                          }
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
