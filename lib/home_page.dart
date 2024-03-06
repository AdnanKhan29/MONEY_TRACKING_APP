import 'package:flutter/material.dart';
import 'package:moneytracker/form_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _persons = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Color(0xff85bb65), // Replace with your desired color
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () async {
                // Navigate to FormPage and wait for result
                final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => FormPage()));

                // Check if result is not null
                if (result != null) {
                  // Retrieve submitted data and set default spending
                  setState(() {
                    _persons.add({
                      'name': result['name'],
                      'age': result['age'],
                      'spending': 0, // Default spending value
                    });
                  });
                }
              },
              child: Text('Add Person!'),
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _persons.map((person) {
                return Card(
                  color: Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.grey[300]!),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text('Name: ${person['name']}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text('Age: ${person['age']}', style: TextStyle(fontSize: 16)),
                        SizedBox(height: 8),
                        Text('Spending: ${person['spending']}', style: TextStyle(fontSize: 16)),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            // Show dialog to add money
                            showDialog(
                              context: context,
                              builder: (context) {
                                int moneyToAdd = 0;
                                return AlertDialog(
                                  title: Text('Add Money'),
                                  content: TextField(
                                    decoration: InputDecoration(labelText: 'Enter amount'),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      moneyToAdd = int.tryParse(value) ?? 0;
                                    },
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        // Close dialog
                                        Navigator.pop(context);
                                      },
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Add money to spending
                                        setState(() {
                                          person['spending'] += moneyToAdd;
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Text('Submit'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text('Add Money'),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xffe8e9c9),
    );
  }
}
