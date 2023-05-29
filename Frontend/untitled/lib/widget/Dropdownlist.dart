
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class Dropdownlist extends StatefulWidget {
  const Dropdownlist({Key? key}) : super(key: key);

  @override
  _DropdownlistState createState() => _DropdownlistState();
}


class _DropdownlistState extends State<Dropdownlist> {

  String dropdownvalue = 'Repair';

  static List<String> items = [
    'Repair',
    'Petrol Service',
    'Puncture Services',
    'Vehicle inspection',
    'Engine oil',
    'Tuning',
    'Tyre',
    'Filter replacement'
  ];
  final _items = items.map((val) => MultiSelectItem<String>(val, val)).toList();

  @override
  Widget build(BuildContext context) {

    return    Container(
       child:Column(
        children:[
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(top: 18.0, bottom:8.0),
            child: MultiSelectDialogField(
              items: _items,
              // title: Text("Select Services"),
              selectedColor: Colors.deepPurpleAccent,
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent.withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: Colors.deepPurpleAccent,
                  width: 2,
                ),
              ),
              buttonIcon: Icon(
                Icons.car_crash_outlined,
                color: Colors.grey,
              ),
              buttonText: Text(
                "Search Services",
                style: TextStyle(
                  color: Colors.blue[800],
                ),
              ),
              onConfirm: (results) async {
                            final _prefs = await SharedPreferences.getInstance();

                            setState((){

                              dropdownvalue = results.toString()!;
                              if (_prefs.getString('requestedService') != null){
                                _prefs.remove('requestedService');
                              }
                                _prefs.setString('requestedService',dropdownvalue);
                                print("Set dropdown: " +dropdownvalue);
              });
                            },
            ),
          ),

        ],
      ),
    );
  }
}