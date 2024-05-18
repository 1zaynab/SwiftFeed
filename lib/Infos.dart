import 'package:finalapp/pages/interest_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class InfosPage extends StatefulWidget {
  const InfosPage({Key? key}) : super(key: key);

  @override
  _InfosPageState createState() => _InfosPageState();
}

class _InfosPageState extends State<InfosPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _cityController = TextEditingController();

  String _id = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String existingId = prefs.getString('id') ?? '';
    _id = existingId.isNotEmpty ? existingId : await _generateId();
    setState(() {
      _nameController.text = prefs.getString('name') ?? '';
      _ageController.text = prefs.getInt('age')?.toString() ?? '';
      _cityController.text = prefs.getString('city') ?? '';
    });
  }

  Future<String> _generateId() async {
    final prefs = await SharedPreferences.getInstance();
    String existingId = prefs.getString('id') ?? '';
    if (existingId.isNotEmpty) {
      return existingId; // Return the existing ID if it's already saved
    }

    // Generate a new ID if it doesn't exist
    final random = Random();
    final randomString = String.fromCharCodes(
      List.generate(4, (index) => random.nextInt(26) + 65),
    );
    final randomNumber = random.nextInt(900000) + 100000;
    final newId = '$randomString$randomNumber';
    await prefs.setString('id', newId); // Save the new ID
    return newId;
  }

  Future<void> _saveData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text);
    await prefs.setString('id', _id); // Save the ID
    await prefs.setInt('age', int.parse(_ageController.text));
    await prefs.setString('city', _cityController.text);

    try {
      // Save user profile to Firestore
      await FirebaseFirestore.instance.collection('users').doc(_id).set({
        'name': _nameController.text,
        'age': int.parse(_ageController.text),
        'city': _cityController.text,
      }, SetOptions(merge: true));

      // Navigate to InterestPage after saving data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InterestPage(id: _id),
        ),
      );
    } catch (e) {
      print('Error saving data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: const Text(
          'Profile Page',
          style: TextStyle(color: Colors.pink),
        ),
        backgroundColor: Colors.pink.shade100,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: const TextStyle(
                    color: Colors.pink,
                    fontWeight: FontWeight.bold,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.pink),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.pink),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                style: const TextStyle(color: Colors.pinkAccent),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(
                  labelText: 'Age',
                  labelStyle: const TextStyle(
                    color: Colors.pink,
                    fontWeight: FontWeight.bold,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.pink),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.pink),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.pinkAccent),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: 'City',
                  labelStyle: const TextStyle(
                    color: Colors.pink,
                    fontWeight: FontWeight.bold,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.pink),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.pink),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                style: const TextStyle(color: Colors.pinkAccent),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your city';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _saveData();
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.pinkAccent.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
