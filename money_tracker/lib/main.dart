import 'package:flutter/material.dart';
import 'package:money_tracker/home_page.dart';
import 'package:money_tracker/landing_page.dart';
// Replace with your project name

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Home Page',
      theme: ThemeData(
        primaryColor: const Color(0xff85bb65),
      ),
      home: LandingPage(),
    );
  }
}
