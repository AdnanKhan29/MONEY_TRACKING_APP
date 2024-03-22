import 'package:flutter/material.dart';

class PersonDetailPage extends StatelessWidget {
  final Map<String, dynamic> person;

  const PersonDetailPage({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Person Details'),
        backgroundColor: Color(0xff85bb65),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Name: ${person['name'].toUpperCase()}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 12),
            Text('Age: ${person['age']}', style: TextStyle(fontSize: 18, color: Colors.black87)),
            SizedBox(height: 12),
            Text('Current: ${person['current']}', style: TextStyle(fontSize: 18, color: Colors.black87)),
            SizedBox(height: 24),
            Text(
              'Transactions:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: person['transactions'].map<Widget>((transaction) {
                // Determine color based on transaction amount
                Color textColor = transaction['amount'] > 0 ? Colors.green.shade100 : Colors.red.shade100;
                return Card(
                  elevation: 2,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  color: transaction['amount'] > 0 ? Colors.green : Colors.red,
                  child: ListTile(
                    title: Text(
                      'Amount: ${transaction['amount']}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    subtitle: Text(
                      'Description: ${transaction['description']}',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    trailing: Text(
                      'Date: ${transaction['timestamp']}',
                      style: TextStyle(fontSize: 14, color: Colors.white),
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