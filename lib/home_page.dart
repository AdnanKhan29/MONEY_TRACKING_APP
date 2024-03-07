import 'package:flutter/material.dart';
import 'package:moneytracker/form_page.dart';
import 'package:moneytracker/person_detail_page.dart';

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
                  // Retrieve submitted data and set default current
                  setState(() {
                    _persons.add({
                      'name': result['name'],
                      'age': result['age'],
                      'current': 0, // Default current value
                      'transactions': [], // List to store transactions
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
                  child: InkWell(
                    onTap: () {
                      // Navigate to detail page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonDetailPage(person: person),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text('Name: ${person['name']}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text('Age: ${person['age']}', style: TextStyle(fontSize: 16)),
                          SizedBox(height: 8),
                          Text('Current: ${person['current']}', style: TextStyle(fontSize: 16)),
                          SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              // Show dialog to add money
                              showDialog(
                                context: context,
                                builder: (context) {
                                  int moneyToAdd = 0;
                                  String description = '';
                                  return AlertDialog(
                                    title: Text('Add Money'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          decoration: InputDecoration(labelText: 'Enter amount'),
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            moneyToAdd = int.tryParse(value) ?? 0;
                                          },
                                        ),
                                        TextField(
                                          decoration: InputDecoration(labelText: 'Enter description'),
                                          onChanged: (value) {
                                            description = value;
                                          },
                                        ),
                                      ],
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
                                          // Add money to current and save transaction
                                          setState(() {
                                            person['current'] += moneyToAdd;
                                            person['transactions'].add({
                                              'amount': moneyToAdd,
                                              'description': description,
                                              'timestamp': DateTime.now(),
                                            });
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
                          SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              // Show dialog to spend money
                              showDialog(
                                context: context,
                                builder: (context) {
                                  int moneyToSpend = 0;
                                  String description = '';
                                  return AlertDialog(
                                    title: Text('Spend Money'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          decoration: InputDecoration(labelText: 'Enter amount'),
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            moneyToSpend = int.tryParse(value) ?? 0;
                                          },
                                        ),
                                        TextField(
                                          decoration: InputDecoration(labelText: 'Enter description'),
                                          onChanged: (value) {
                                            description = value;
                                          },
                                        ),
                                      ],
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
                                          // Spend money and save transaction
                                          setState(() {
                                            person['current'] -= moneyToSpend;
                                            person['transactions'].add({
                                              'amount': -moneyToSpend, // negative amount for spending
                                              'description': description,
                                              'timestamp': DateTime.now(),
                                            });
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
                            child: Text('Spend Money'),
                          ),
                        ],
                      ),
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
