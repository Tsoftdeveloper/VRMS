import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/CarOwner/viewMechanicProfile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MechanicList extends StatefulWidget {
  const MechanicList({Key? key}) : super(key: key);

  @override
  State<MechanicList> createState() => _MechanicListState();
}

class _MechanicListState extends State<MechanicList> {
  String appointedDate = "", reqLocation = "", reqService = "";
  Map emap = new Map();
  List reqBit = [];

  @override
  void initState() {
    super.initState();
    _sharedPref();
  }

  Map mechuser1 = {
    "id": "1",
    "email": "tylerchane@yahoo.com",
    "fullname": "Tyler Chane",
    "city": "Karachi",
    "cell": "03009283676",
    "services":
        "Repair, Petrol Service, Puncture Services, Vehicle inspection, Engine oil, tuning, Tyre rotation and Filter replacement.",
    "rating": "4.5",
    "image": "https://xsgames.co/randomusers/assets/avatars/male/74.jpg",
  };
  Map mechuser2 = {
    "id": "2",
    "email": "chris@gmail.com",
    "fullname": "Chris Bale",
    "city": "Islamabad",
    "cell": "03009283676",
    "services":
        "Repair, Oil Monitoring, Engine Fix, Petrol Service, Puncture Services, Vehicle inspection",
    "rating": "3.5",
    "image":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ-YIPLhIBLVQKh_S4BNo18b03Ct5P_iYFeBBjDCYx&s",
  };

  Map mechuser3 = {
    "id": "3",
    "email": "danny@gmail.com",
    "fullname": "Danny",
    "city": "Karachi",
    "cell": "03009283676",
    "services":
        "Petrol Service,Repair, Puncture Services, Vehicle inspection, Engine oil, tuning, Tyre rotation and Filter replacement.",
    "rating": "4.5",
    "image":
        "https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg",
  };

  send() async {

    final _prefs = await SharedPreferences.getInstance();
    print("in Mechanic List");
    print(reqBit.length);
    if (reqBit.length > 0) {
      setState(() {
        _prefs.setString('reqBit', jsonEncode(reqBit));
      });
    }


  }

  Future<void> _sharedPref() async {
    final _prefs = await SharedPreferences.getInstance();
    setState(() {
      reqLocation = (_prefs.getString('reqLocation') ?? '');
      reqService = (_prefs.getString('requestedService') ?? '');
      if (reqService.isEmpty) {
        reqService = "Repair";
      }
      if (_prefs.getString('reqBit') != null){
        _prefs.remove("reqBit");
      }
    });
    print("reqLocation : " +reqLocation);
    print("reqService : " +reqService);

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Card(
              elevation: 3.0,
              color: Colors.white,
              child: Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(mechuser1[
                              "image"]), // No matter how big it is, it won't overflow
                        ),
                        title: Text(mechuser1["fullname"]),
                        subtitle: Flexible(
                          fit: FlexFit.loose,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.pin_drop_outlined,
                                          color: Colors.deepPurpleAccent)),
                                  Text(
                                    reqLocation,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  Expanded(
                                    child: Align(
                                      alignment: AlignmentDirectional.topEnd,
                                      child: Text("PKR 2000"),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.miscellaneous_services,
                                          color: Colors.deepPurpleAccent)),
                                  Text(
                                    "Found match for: " + reqService,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        TextButton(
                          child: const Text('View Profile'),
                          onPressed: () async {
                            final _prefs =
                                await SharedPreferences.getInstance();

                            setState(() {
                              _prefs.setString(
                                  'viewuser', json.encode(mechuser1));
                            });
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const viewMechanicProfile(),
                              ),
                            );
                          },
                        ),
                        TextButton(
                          child: const Text('Call'),
                          onPressed: () =>
                              launchUrlString("tel://" + mechuser1["cell"]),
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          child: const Text('Request'),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      title: Text(
                                          "Request has been sent and approved. Mechanic will be there in a few minutes."),
                                      actions: <Widget>[
                                        TextButton(
                                          child: new Text('OK'),
                                          onPressed: () async {

                                            reqBit.add(mechuser1["fullname"]+" has accepted your request");
                                            // final _prefs = await SharedPreferences.getInstance();
                                            // setState(() {
                                            //   _prefs.setString('reqBit',jsonEncode(reqBit));
                                            // });
                                             send();
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ]);
                                });
                          },
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Card(
              elevation: 3.0,
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ-YIPLhIBLVQKh_S4BNo18b03Ct5P_iYFeBBjDCYx&s"), // No matter how big it is, it won't overflow
                      ),
                      title: Text('Chris Bale'),
                      subtitle: Flexible(
                        fit: FlexFit.loose,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.pin_drop_outlined,
                                        color: Colors.deepPurpleAccent)),
                                Text(
                                  reqLocation,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional.topEnd,
                                    child: Text("PKR 3000"),
                                  ),
                                ),

                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.miscellaneous_services,
                                        color: Colors.deepPurpleAccent)),
                                Text(
                                  "Found match for: " + reqService,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextButton(
                        child: const Text('View Profile'),
                        onPressed: () async {
                          final _prefs = await SharedPreferences.getInstance();

                          setState(() {
                            _prefs.setString(
                                'viewuser', json.encode(mechuser2));
                          });
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const viewMechanicProfile(),
                            ),
                          );
                        },
                      ),
                      TextButton(
                        child: const Text('Call'),
                        onPressed: () =>
                            launchUrlString("tel://" + mechuser2["cell"]),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                          child: const Text('Request'),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      title: Text(
                                          "Request has been sent and approved. Mechanic will be there in a few minutes."),
                                      actions: <Widget>[
                                        TextButton(
                                          child: new Text('OK'),
                                          onPressed: () async {
                                            reqBit.add(mechuser2["fullname"]+" has accepted your request");
                                            send();
                                            // final _prefs = await SharedPreferences.getInstance();
                                            // setState(() {
                                            //   _prefs.setString('reqBit',jsonEncode(reqBit));
                                            // });
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ]);
                                });
                          }),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Card(
              elevation: 3.0,
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg"), // No matter how big it is, it won't overflow
                      ),
                      title: Text('Danny'),
                      subtitle: Flexible(
                        fit: FlexFit.loose,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.pin_drop_outlined,
                                        color: Colors.deepPurpleAccent)),
                                Text(
                                  reqLocation,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional.topEnd,
                                    child: Text("PKR 4000"),
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.miscellaneous_services,
                                        color: Colors.deepPurpleAccent)),
                                Text(
                                  "Found match for: " + reqService,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextButton(
                        child: const Text('View Profile'),
                        onPressed: () async {
                          final _prefs = await SharedPreferences.getInstance();

                          setState(() {
                            _prefs.setString(
                                'viewuser', json.encode(mechuser3));
                          });
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const viewMechanicProfile(),
                            ),
                          );
                        },
                      ),
                      TextButton(
                        child: const Text('Call'),
                        onPressed: () =>
                            launchUrlString("tel://" + mechuser3["cell"]),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        child: const Text('Request'),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    title: Text(
                                        "Request has been sent. Mechanic will respond in a while."),
                                    actions: <Widget>[
                                      TextButton(
                                        child: new Text('OK'),
                                        onPressed: () async {
                                          reqBit.add(mechuser3["fullname"]+" has accepted your request");
                                          send();
                                          // final _prefs = await SharedPreferences.getInstance();
                                          //
                                          // setState(() {
                                          //   _prefs.setString('reqBit',jsonEncode(reqBit));
                                          // });
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ]);
                              });
                        },
                      ),

                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
