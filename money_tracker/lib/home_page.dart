import 'package:flutter/material.dart';
import 'package:money_tracker/form_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Color(0xff85bb65), // Replace with your desired color
      ),
      body: Stack(
        children: [
          // Background content (optional)
          Center(
            // Your main content here (optional)
          ),
          Positioned(
            bottom: 20.0, // Adjust vertical position as needed
            left: 60.0, // Adjust horizontal position (optional)
            right: 60.0, // Adjust horizontal position (optional)
            child: ElevatedButton(
              onPressed: () {
                // Navigate to form.dart
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FormPage()),
                );
              },
              child: Text(
                'Add Person!',
                style: TextStyle(color: Colors.white), // Set text color here
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  // Adjust as needed
                ),
                backgroundColor: Color(0xff85bb65), // Inner button color
                shadowColor: Colors.grey[300], // Shadow color
                elevation: 4, // Adjust shadow intensity
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xffe8e9c9),
    );
  }
}
