import 'package:flutter/material.dart';
import 'package:moneytracker/home_page.dart';
import 'package:moneytracker/landing_page.dart';
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
