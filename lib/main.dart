import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.deepPurple,
        ),
        //...
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  Future<void> _saveContact() async {
    String name = _nameController.text.trim();
    String phone = _phoneController.text.trim();

    // TO NOTE:
    // final apiUrl = 'YOUR_DJANGO_SERVER_URL/save_contact/';
    // final apiUrl = Uri.parse('http://127.0.0.1:8000/fetch_days_deliveries/?userEmail=$userEmail&dateFilter=$formattedDate');


    final apiUrl = Uri.parse('http://127.0.0.1:8000/save_data/');

    try {
      final response = await http.post(
        apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'phone': phone,
        }),
      );

      if (response.statusCode == 200) {
        print('Contact saved successfully');
        // Handle success, e.g., show a success message or navigate to a new screen
      } else {
        print('Failed to save contact: ${response.statusCode}');
        // Handle error, show an error message
      }
    } catch (e) {
      print('Exception occurred: $e');
      // Handle exceptions, show an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveContact,
              child: Text('Save Contact'),
            ),
          ],
        ),
      ),
    );
  }
}
