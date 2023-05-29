import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final User user;

  UserCard({required this.user});
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
                user.name,
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(user.contact),
              SizedBox(height: 8.0),
              Text(
                "Experience:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(user.experience),
            ],
          ),
        ),
      ),
    );
  }
}
class User {
  final String name;
  final String contact;
  final String experience;

  User({
    required this.name,
    required this.contact,
    required this.experience,
  });
}