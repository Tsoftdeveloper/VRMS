import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrackRequestsScreen extends StatefulWidget {
  @override
  _TrackRequestsScreenState createState() => _TrackRequestsScreenState();
}

class _TrackRequestsScreenState extends State<TrackRequestsScreen> {
  List<Request> _requests = []; // Replace with actual request data
 String complete = "Complete";
 bool display = false;
 bool show = true;

  @override
  void initState() {
    super.initState();
    _sharedPref();
  }



  Future<void> _sharedPref() async {
    final _prefs = await SharedPreferences.getInstance();
    setState(() {
      if ( _prefs.getString('acceptedUser') != null) {
        String acceptedUser = (_prefs.getString('acceptedUser') ?? '');

        _requests.add(Request(customerName: acceptedUser,
            serviceType: "Repair, Petrol Tuning",
            customerContact: "03354555555"));
      }
      });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Requests'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _requests.length,
          itemBuilder: (context, index) {
            return _buildRequestCard(context, _requests[index]);
          },
        ),
      ),
    );
  }

  Widget _buildRequestCard(BuildContext context, Request request) {
    return Card(
      color: Colors.green[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              request.customerName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              request.serviceType,
            ),
            SizedBox(height: 8.0),
            Text(
              request.customerContact,
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Visibility(
                  visible: show,
                  child: ElevatedButton(
                    onPressed: () {

                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                title: Text("Have you completed the service?"),
                                content: Text("Make sure to recieve the payment in hand."),
                                actions: <Widget>[
                                  TextButton(
                                    child: new Text('OK'),
                                    onPressed: () {
                                      setState(() {
                                        show = false;
                                        display = true;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ]);
                          });
                    },
                    child: Text(complete),
                  ),
                ),

                Visibility(
                    visible: display,
                    child: Text("Completed")),
                SizedBox(width: 8.0),
                // ElevatedButton(
                //   onPressed: () {
                //     // Navigate to request details screen
                //   },
                //   child: Text('Details'),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Request {
  final String customerName;
  final String serviceType;
  final String customerContact;

  Request({
    required this.customerName,
    required this.serviceType,
    required this.customerContact,
  });
}