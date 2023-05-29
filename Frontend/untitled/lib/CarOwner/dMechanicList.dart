import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class dMechanicList extends StatefulWidget {
  const dMechanicList({Key? key}) : super(key: key);

  @override
  State<dMechanicList> createState() => _dMechanicListState();
}

class _dMechanicListState extends State<dMechanicList> {
  Map<String, Map<String, dynamic>> result = {};
  String resultString = "";

  @override
  void initState() {
    super.initState();
    _sharedPref();
  }



  Future<void> _sharedPref() async {
    final _prefs = await SharedPreferences.getInstance();
    setState(() {
      resultString = (_prefs.getString('results') ?? '');
    });

    Map<String, dynamic> jsonMap = json.decode(resultString);
    Map<String, Map<String, dynamic>> result = jsonMap.cast<String, Map<String, dynamic>>();


    print("In DMechanicList: " +result.toString());
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("List")),
      body: Center(

          child: ListView.builder(
            itemCount: result.length,
            itemBuilder: (BuildContext context, int index) {
              String key = result.keys.elementAt(index);
              Map<String, dynamic>? data = result[key];
              return ListTile(
                title: Text(data?[1]),
              );
            },
          )

      ),
    );
  }
}
