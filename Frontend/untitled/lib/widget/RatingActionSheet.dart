import 'package:flutter/material.dart';

class RatingActionSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.sentiment_very_satisfied),
            title: Text('Excellent'),
            onTap: () {
              Navigator.pop(context, 5);
            },
          ),
          ListTile(
            leading: Icon(Icons.sentiment_satisfied),
            title: Text('Good'),
            onTap: () {
              Navigator.pop(context, 4);
            },
          ),
          ListTile(
            leading: Icon(Icons.sentiment_neutral),
            title: Text('Average'),
            onTap: () {
              Navigator.pop(context, 3);
            },
          ),
          ListTile(
            leading: Icon(Icons.sentiment_dissatisfied),
            title: Text('Poor'),
            onTap: () {
              Navigator.pop(context, 2);
            },
          ),
          ListTile(
            leading: Icon(Icons.sentiment_very_dissatisfied),
            title: Text('Terrible'),
            onTap: () {
              Navigator.pop(context, 1);
            },
          ),
        ],
      ),
    );
  }
}
