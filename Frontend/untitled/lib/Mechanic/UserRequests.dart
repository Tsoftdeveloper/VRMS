import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../CarOwner/Dashboard.dart';
import 'MechanicDashboard.dart';

class UserRequests extends StatefulWidget {
  const UserRequests({Key? key}) : super(key: key);

  @override
  State<UserRequests> createState() => _UserRequestsState();
}

class _UserRequestsState extends State<UserRequests> {
  final items = List<String>.generate(1, (i) => 'Item ${i + 1}');
  bool show = true;
  bool display = true;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(parent: NeverScrollableScrollPhysics()),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Dismissible(
            key: Key(item),
            // Provide a function that tells the app
            // what to do after an item has been swiped away.
            onDismissed: (direction) {
              // Remove the item from the data source.
              setState(() {
                items.removeAt(index);
              });

              // Then show a snackbar.
              // ScaffoldMessenger.of(context)
              //     .showSnackBar(SnackBar(content: Text('$item dismissed')));
            },
            child: Card(
              elevation: 3.0,
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                            "https://www.shareicon.net/data/512x512/2016/07/26/802043_man_512x512.png"), // No matter how big it is, it won't overflow
                      ),
                      title: Text('Harry'),
                      subtitle: Text('is looking for [Repair, Petrol Tuning]'),

                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Visibility(
                        visible: display,
                        child: TextButton(
                          child: const Text(
                            'Accept',
                            style: TextStyle(color: Colors.green),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      content: Text('Request Accepted.'),
                                      actions: <Widget> [
                                        TextButton(
                                          child: new Text('OK'),
                                          onPressed: () async {
                                            final _prefs = await SharedPreferences.getInstance();

                                            setState(() {
                                              if (_prefs.getString('acceptedUser') != null){
                                                _prefs.remove("acceptedUser");
                                              }
                                              _prefs.setString('acceptedUser', "Harry");
                                              show = false;

                                            });

                                            Navigator.of(context).pop(

                                            );
                                          },
                                        )
                                      ]
                                  );
                                });
                          },
                        ),
                      ),
                      TextButton(
                        child: const Text('Call'),
                        onPressed: () => launchUrlString("tel://03333333633"),
                      ),
                      const SizedBox(width: 8),
                      Visibility(
                        visible: show,
                        child: TextButton(
                          child: const Text(
                            'Decline',
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      content: Text('Request Declined.'),
                                      actions: <Widget> [
                                        TextButton(
                                          child: new Text('OK'),
                                          onPressed: () async {
                                            final _prefs = await SharedPreferences.getInstance();

                                            setState(() {
                                              if (_prefs.getString('rejectedUser') != null){
                                                _prefs.remove("rejectedUser");
                                              }
                                              _prefs.setString('rejectedUser', "Harry");
                                              display = false;

                                            });
                                            Navigator.of(context).pop(

                                            );
                                          },
                                        )
                                      ]
                                  );
                                });
                          },
                        ),
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
}
