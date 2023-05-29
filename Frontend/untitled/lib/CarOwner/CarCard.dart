import 'package:flutter/material.dart';

class CarCard extends StatelessWidget {
  final Car car;

  CarCard({required this.car});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.1,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                car.company,
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text("Car ID: " +car.model),
              SizedBox(height: 8.0),
              Text("Engine Type: "+car.engineType),
              SizedBox(height: 8.0),
              Text("Engine Capacity: " +car.engineCapacity),
              SizedBox(height: 8.0),
              Text("Milage: "+car.milage),
            ],
          ),
        ),
      ),
    );
  }
}

class Car {
  final String company;
  final String model;
  final String engineType;
  final String engineCapacity;
  final String milage;

  Car({required this.company, required this.model, required this.engineType, required this.engineCapacity, required this.milage});
}