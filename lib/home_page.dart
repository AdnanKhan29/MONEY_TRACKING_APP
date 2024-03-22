import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moneytracker/form_page.dart';
import 'package:moneytracker/person_detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> _persons = [];

  Future<void> _fetchPersons() async {
    final response = await http.get(Uri.parse('http://localhost:3000/api/persons'));
    if (response.statusCode == 200) {
      setState(() {
        _persons = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load persons');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPersons();
  }

  Future<void> _addMoney(String id, int amount, String description) async {
    final response = await http.put(
      Uri.parse('http://localhost:3000/api/persons/$id/addMoney'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'amount': amount,
        'description': description,
      }),
    );

    if (response.statusCode == 200) {
      await _fetchPersons(); // Refresh persons list after updating balance
    } else {
      throw Exception('Failed to add money');
    }
  }

  Future<void> _spendMoney(String id, int amount, String description) async {
    final response = await http.put(
      Uri.parse('http://localhost:3000/api/persons/$id/spendMoney'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'amount': amount,
        'description': description,
      }),
    );

    if (response.statusCode == 200) {
      await _fetchPersons(); // Refresh persons list after updating balance
    } else {
      throw Exception('Failed to spend money');
    }
  }

  Future<void> _deletePerson(String id) async {
    final response = await http.delete(Uri.parse('http://localhost:3000/api/persons/$id'));

    if (response.statusCode == 200) {
      await _fetchPersons(); // Refresh persons list after deleting
    } else {
      throw Exception('Failed to delete person');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Color(0xff85bb65),
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

                // Fetch updated list of persons after adding a new person
                if (result != null && result) {
                  await _fetchPersons();
                }
              },
              child: Text('Add Person!'),
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _persons.map<Widget>((person) {
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text('Name: ${person['name']}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text('Age: ${person['age']}', style: TextStyle(fontSize: 16)),
                          SizedBox(height: 8),
                          Text('Current: ${person['current']}', style: TextStyle(fontSize: 16)),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                flex: 1,
                                child: ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => _buildMoneyDialog(context, person['_id'], true),
                                    );
                                  },
                                  child: Text('Add Money'),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => _buildMoneyDialog(context, person['_id'], false),
                                    );
                                  },
                                  child: Text('Spend Money'),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Confirm Delete'),
                                  content: Text('Are you sure you want to delete this person?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () async {
                                        await _deletePerson(person['_id']);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Yes'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('No'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Text('Delete Person'),
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

  Widget _buildMoneyDialog(BuildContext context, String personId, bool isAddingMoney) {
    TextEditingController _amountController = TextEditingController();
    TextEditingController _descriptionController = TextEditingController();

    return AlertDialog(
        title: Text(isAddingMoney ? 'Add Money' : 'Spend Money'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: <Widget>[
        TextButton(
        onPressed: () {
      Navigator.of(context).pop();
    },
    child: Text('Cancel'),
    ),
    TextButton(
    onPressed: () async {
    int amount = int.tryParse(_amountController.text) ?? 0;
    String description = _descriptionController.text;
    if (isAddingMoney) {
    await _addMoney(personId, amount, description);
    } else {
    await _spendMoney(personId, amount, description);
    }
    Navigator.of(context).pop();
    },
      child: Text('Submit'),
    ),
        ],
    );
  }
}
