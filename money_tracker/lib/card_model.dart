  child: ElevatedButton(
  onPressed: () async {
  // Navigate to form.dart
  final Map<String, String>? result = await Navigator.of(context).push(
  MaterialPageRoute(builder: (context) => FormPage()),
  );
  if (result != null) {
  _addPerson(result);
  }
  },
  child: Text(
  'Add Person!',
  style: TextStyle(color: Colors.white),
  ),
  style: ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(10.0),
  ),
  backgroundColor: Color(0xff85bb65),
  shadowColor: Colors.grey[300],
  elevation: 4,
  ),
  ),
  ),
  ListView.builder(
  itemCount: _persons.length,
  itemBuilder: (context, index) {
  final person = _persons[index];
  return Card(
  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  child: ListTile(
  title: Text(person['name'] ?? ''),
  subtitle: Text('Age: ${person['age'] ?? ''}'),
  ),
  );
  },
  ),
  ],
  ),
  backgroundColor: Color(0xffe8e9c9),
  );
  }
  }