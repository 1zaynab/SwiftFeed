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

  late String _id; // Initialize _id as late variable
  bool _isDataSaved = false; // Track whether data is saved

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

  Future<void> _saveData({bool navigateToInterests = false}) async {
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

      setState(() {
        _isDataSaved = true; // Set data saved flag to true
      });

      // Show SnackBar with "Saved Successfully" message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saved Successfully')),
      );

      if (navigateToInterests) {
        // Navigate to InterestPage after saving data with the related ID
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InterestPage(id: _id),
          ),
        );
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      print('Error saving data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyMedium!.color;

    return WillPopScope(
      onWillPop: () async {
        if (_isDataSaved) {
          return true; // Allow back navigation
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please click on save')),
          );
          return false; // Prevent back navigation
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Gradient Overlay
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent, // Start with transparent
                    Color(0xFFFDABAB), // End with your preferred color
                  ],
                ),
              ),
            ),
            // Center the content
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(25.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Fill Your Informations", style: TextStyle(fontSize: 30),),
                      SizedBox(height: 90),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(
                            color: textColor, // Dynamic text color
                            fontWeight: FontWeight.bold,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white), // Replace with your desired color
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white), // Replace with your desired color
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        style: TextStyle(color: textColor), // Dynamic text color
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 25.0),
                      TextFormField(
                        controller: _ageController,
                        decoration: InputDecoration(
                          labelText: 'Age',
                          labelStyle: TextStyle(
                            color: textColor, // Dynamic text color
                            fontWeight: FontWeight.bold,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white), // Replace with your desired color
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white), // Replace with your desired color
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: textColor), // Dynamic text color
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
                      const SizedBox(height: 25.0),
                      TextFormField(
                        controller: _cityController,
                        decoration: InputDecoration(
                          labelText: 'City',
                          labelStyle: TextStyle(
                            color: textColor, // Dynamic text color
                            fontWeight: FontWeight.bold,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white), // Replace with your desired color
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white), // Replace with your desired color
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        style: TextStyle(color: textColor), // Dynamic text color
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your city';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 25.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _saveData();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              minimumSize: const Size(80, 80),
                              padding: const EdgeInsets.all(20.0),
                              elevation: 5.0,
                              shadowColor: Colors.grey.withOpacity(0.5),
                              foregroundColor: Colors.white70, backgroundColor: const Color(
                                0xFFC97A7C),
                            ),
                            child: const Text(
                              'Save',
                              style: TextStyle(color: Colors.white60), // Set the text color to white
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _saveData(navigateToInterests: true);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              minimumSize: const Size(80, 80),
                              padding: const EdgeInsets.all(20.0),
                              elevation: 5.0,
                              shadowColor: Colors.grey.withOpacity(0.5),
                              foregroundColor: Colors.white70, backgroundColor: const Color(
                                0xFFC97A7C),
                            ),
                            child: const Text(
                              'Continue',
                              style: TextStyle(color: Colors.white60), // Set the text color to white
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
