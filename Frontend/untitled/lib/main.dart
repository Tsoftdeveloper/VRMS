import 'package:flutter/material.dart';
import 'Login.dart';
void main() {
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Car Repair System',
        theme: ThemeData(
          colorSchemeSeed: Colors.brown,
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const Login(),

    },
      ));
}
