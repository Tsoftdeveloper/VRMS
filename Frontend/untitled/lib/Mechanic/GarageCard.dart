import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GarageCard extends StatelessWidget {
  final Garage garage;

  GarageCard({required this.garage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/1.2,
      child: Card(

        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                garage.name,
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(garage.location),
              SizedBox(height: 8.0),
              Text(garage.phoneNumber),
              SizedBox(height: 16.0),
              Text(
                "Services:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(garage.services),
            ],
          ),
        ),
      ),
    );
  }
}

class Garage {
   String name;
   String location;
   String phoneNumber;
   String services;

  Garage({required this.name, required this.location, required this.phoneNumber, required this.services});
}