import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Models/user.dart';
import 'package:untitled/widget/BottomNavBar.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_google_places_web/flutter_google_places_web.dart';
import '../Models/Mechanic.dart';
import '../widget/Dropdownlist.dart';
import 'MechanicList.dart';
import '../Login.dart';
import 'dMechanicList.dart';

const kGoogleApiKey = "AIzaSyAsAFoAdUhb6nv4AH4svTyrYm-6ikFOC4A";

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final _formKey = GlobalKey<FormState>();
  String service = "";
  bool check = false;


  bool recheck = false;
  List myMap = [];
  Map<String, dynamic> decodedData = {};
  Map<String, Map<String, dynamic>> result = {};
  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    updateCheck();
  }


  updateCheck() async {
    final _prefs = await SharedPreferences.getInstance();
    print(_prefs.getString('check') );
    if ( _prefs.getString('check') == "true"){
      setState(() {
        recheck = true;
      });
    }else{
          setState(() {
          recheck = false;
          });
    }
  }

  Future<void> _trySubmitForm() async {
    final bool? isValid = _formKey.currentState?.validate();
    if (service.isNotEmpty && controller.text.isNotEmpty) {
      final _prefs = await SharedPreferences.getInstance();

      setState(() {
        service = _prefs.getString('requestedService')!;
      });

      buttonPressed();
    }
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
      "Services": "Repair",
    });

    request.headers.addAll(headers);

    final response = await request.send();
    final respStr = await response.stream.bytesToString();
    final decoded = jsonDecode(respStr);

    decodedData = jsonDecode(decoded);

    result = decodedData.map((key, value) => MapEntry(
        key, Map<String, dynamic>.from(value.cast<String, dynamic>())));


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
      final _prefs = await SharedPreferences.getInstance();

      setState(() {
        _prefs.setString('results', jsonEncode(result));
      });

      ListView.builder(
        itemCount: result.length,
        itemBuilder: (BuildContext context, int index) {
          String key = result.keys.elementAt(index);
          Map<String, dynamic>? data = result[key];
          return ListTile(
            title: Text(data?[1]),
          );
        },
      );
    }

    return respStr;
  }

  @override
  Widget build(BuildContext context) {
    double? scrolledUnderElevation;
    super.build(context);

    return PageStorage(
      bucket: PageStorageBucket(),
      child: MaterialApp(
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
          bottomNavigationBar: BottomNavbar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Center(
                                child: FlutterGooglePlacesWeb(
                                  controller: controller,

                                  components: 'country:pk',
                                  apiKey: kGoogleApiKey,
                                  // proxyURL: 'https://cors-anywhere.herokuapp.com/',
                                  proxyURL: '',
                                  required: true,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.deepPurpleAccent),
                                    ),
                                    border: UnderlineInputBorder(),
                                    icon: Icon(
                                      Icons.pin_drop,
                                      color: Colors.grey,
                                    ),
                                    labelText: 'Select Location',
                                    labelStyle: TextStyle(
                                      color: Colors.deepPurpleAccent,
                                    ),
                                  ),
                                ),
                              ),
                              Center(child: Dropdownlist()),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 8.0, bottom: 10.0),
                                child: ElevatedButton(
                                    onPressed: () async {
                                      final _prefs = await SharedPreferences
                                          .getInstance();
                                      String dropdown = "";
                                      setState(() {
                                        dropdown =  (_prefs.getString('requestedService') ?? '');
                                        print("Service: "+_prefs.getString('requestedService')!);
                                      });

                                      if (controller.text.isNotEmpty && dropdown.isNotEmpty) {

                                        buttonPressed();
                                        setState(() {
                                          check = !check;
                                          if ( _prefs.getString('check') != null){
                                            _prefs.remove("check");
                                          }

                                          _prefs.setString('check', check.toString());
                                          if ( _prefs.getString('reqLocation') != null){
                                            _prefs.remove("reqLocation");
                                          }
                                          _prefs.setString('reqLocation',controller.text);
                                          print("Set Variable: " +_prefs.getString('reqLocation')! );
                                        });
                                      }else{
                                        SnackBar(content: Text("Please enter location & select a service."));
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurpleAccent,
                                      elevation: 3.0,
                                      minimumSize: const Size.fromHeight(50),
                                    ),
                                    child: Text('Find',
                                        style: TextStyle(color: Colors.white))),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Visibility(
                        visible: check,
                        child: MechanicList(),
                      ),
                      Visibility(
                        visible: recheck,
                        child: MechanicList(),
                      ),
                      //dMechanicList(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
