import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Mechanic/TrackRequestsScreen.dart';
import 'package:untitled/widget/MechanicBottomNav.dart';
import 'package:http/http.dart' as http;

import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:untitled/Mechanic/SaveWorkshopDetails.dart';
import '../CarOwner/Dashboard.dart';
import 'UserRequests.dart';
import 'SavePersonalDetails.dart';

const kGoogleApiKey = "AIzaSyAsAFoAdUhb6nv4AH4svTyrYm-6ikFOC4A";

class MechanicDashboard extends StatefulWidget {
  const MechanicDashboard({Key? key}) : super(key: key);

  @override
  State<MechanicDashboard> createState() => _MechanicDashboardState();
}

class _MechanicDashboardState extends State<MechanicDashboard> {
  final _formKey = GlobalKey<FormState>();
  String service = "";

  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();

    // if (isValid == true) {
    //
    //   buttonPressed();
    // }
    print("Service");
  }

  Future<String> buttonPressed() async {
    String API = "MechanicServices";
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('http://127.0.0.1:8000/' + API + '/'));
    print("Service: " + service);
    request.body = json.encode({
      "Username": "",
      "Password": "",
      "Mechanic_Email": "",
      "Full_Name": "",
      "CNIC_Number": "",
      "City": "",
      "Contact_Number": "",
      "Services": "" + service.toLowerCase(),
    });

    request.headers.addAll(headers);

    final response = await request.send();
    final respStr = await response.stream.bytesToString();
    final data = jsonDecode(respStr);
    for (var nums in data) {
      for (var number in nums) {
        print(number);
      }
    }
    // print(data);

    if (response.statusCode != 200) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Text("No Matched Results Found."),
                content: Text('Please try again?'),
                actions: <Widget>[
                  TextButton(
                    child: new Text('OK'),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const Dashboard(),
                        ),
                      );
                    },
                  )
                ]);
          });
    } else {
      Center(
        child: ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(10),
              child: Card(
                color: Colors.white,
                elevation: 3.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const ListTile(
                      title: Text('Tylor Chane'),
                      subtitle: Text(
                          '5 yrs of experience. Offers Services like Car Repair.'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          child: const Text('View Profile'),
                          onPressed: () {},
                        ),
                        TextButton(
                          child: const Text('Call'),
                          onPressed: () {},
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          child: const Text('Request'),
                          onPressed: () {},
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
    return respStr;
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
          title: const Text('Dashboard'),
          scrolledUnderElevation: scrolledUnderElevation,
        ),
        bottomNavigationBar: MechanicBottomNav(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: SizedBox(
                        height: 80,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 60,
                                width: 60,
                                child: Flexible(
                                  child: Card(
                                    elevation: 3.0,
                                    color: Colors.deepPurpleAccent,
                                    child: Column(
                                      children: [
                                        IconButton(
                                            icon: Icon(Icons.settings,
                                                color: Colors.white),
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SavePersonalDetails(),
                                                ),
                                              );
                                            }),
                                        Text(
                                          "Save Personal Details",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 60,
                                width: 60,
                                child: Flexible(
                                  child: Card(
                                    elevation: 3.0,
                                    color: Colors.brown,
                                    child: Column(
                                      children: [
                                        IconButton(
                                            icon: Icon(
                                                Icons.car_repair_outlined,
                                                color: Colors.white),
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SaveWorkshopDetails(),
                                                ),
                                              );
                                            }),
                                        Text(
                                          "Save Workshop Details",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(

                      child: GestureDetector(
                        onTap: () {
                          // Navigate to tracking screen
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => TrackRequestsScreen(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Track User Requests',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                'View and manage all user requests in one place',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    Center(
                      child: UserRequests(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
