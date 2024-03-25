import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  String _name = '';
  int _age = 0;

  Future<void> _addPerson() async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/api/persons'), // Corrected endpoint
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': _name,
        'age': _age,
      }),
    );

    if (response.statusCode == 201) {
      // Person added successfully
      Navigator.pop(context, true);
    } else {
      // Failed to add person, print response body for debugging
      print('Failed to add person: ${response.body}');
      throw Exception('Failed to add person');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Person'),
        backgroundColor: Color(0xff85bb65),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _age = int.tryParse(value) ?? 0;
                  });
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _addPerson();
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xffe8e9c9),
    );
  }
}
