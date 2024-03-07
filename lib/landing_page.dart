import 'package:flutter/material.dart';
import 'package:moneytracker/home_page.dart';
import 'package:moneytracker/login.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    // Simulate a loading delay, then navigate to the home page
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/home_image.png',
              height: 200.0,
            ),
            SizedBox(height: 20),
            Padding(

              child: Text(
                "Money Tracker!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              padding: const EdgeInsets.only(bottom: 12.0),
            ),
            CircularProgressIndicator(), // Loading animation
          ],
        ),
      ),
      backgroundColor: Color(0xff85bb65),
    );
  }
}
