import 'package:flutter/material.dart';
import 'package:money_tracker/home_page.dart';

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
        MaterialPageRoute(builder: (context) => HomePage()),
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
              'assets/home_image.png', // Add your landing image asset path
              height: 200.0,
            ),
            SizedBox(height: 20), // Spacing between image and text
            Padding(
              // Add bottom padding
              child: Text(
                "Money Tracker!", // Replace with your desired text
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
