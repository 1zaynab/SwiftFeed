import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalapp/screens/custom_navigation_bar.dart';
import 'package:finalapp/tweet_service.dart';

class InterestPage extends StatefulWidget {
  final String id;

  InterestPage({required this.id});

  @override
  _InterestPageState createState() => _InterestPageState();
}

class _InterestPageState extends State<InterestPage> {
  final APIService apiService = APIService(baseUrl: 'http://10.0.2.2:5000');
  bool _isPoliticsChecked = false;
  bool _isTechnologyChecked = false;
  bool _isEntertainmentChecked = false;
  List<String> _interests = [];

  Future<void> _loadInterests() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _interests = prefs.getStringList('interests') ?? [];
      _isPoliticsChecked = _interests.contains('Politics');
      _isTechnologyChecked = _interests.contains('Technology');
      _isEntertainmentChecked = _interests.contains('Entertainment');
    });
  }

  Future<void> _saveInterests() async {
    final prefs = await SharedPreferences.getInstance();
    _interests.clear();
    if (_isPoliticsChecked) _interests.add('Politics');
    if (_isTechnologyChecked) _interests.add('Technology');
    if (_isEntertainmentChecked) _interests.add('Entertainment');
    await prefs.setStringList('interests', _interests);

    //Save interests to Firestore
    await FirebaseFirestore.instance.collection('users').doc(widget.id).set({
      'interests': _interests,
    }, SetOptions(merge: true));

    // Navigate to HomePage after saving data
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomNavigationBar(title: '', apiService: apiService,),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadInterests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE0F2F1), // Light blue
                  Color(0xFFA9C5C2), // Darker blue
                ],
              ),
            ),
          ),
          // Center the content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Select Interests',
                    style: TextStyle(
                      color: Colors.pink,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16.0),
                  CheckboxListTile(
                    title: const Text('Politics'),
                    value: _isPoliticsChecked,
                    activeColor: Colors.pinkAccent,
                    checkColor: Colors.white,
                    onChanged: (bool? value) {
                      setState(() {
                        _isPoliticsChecked = value ?? false;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Technology'),
                    value: _isTechnologyChecked,
                    activeColor: Colors.pinkAccent,
                    checkColor: Colors.white,
                    onChanged: (bool? value) {
                      setState(() {
                        _isTechnologyChecked = value ?? false;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Entertainment'),
                    value: _isEntertainmentChecked,
                    activeColor: Colors.pinkAccent,
                    checkColor: Colors.white,
                    onChanged: (bool? value) {
                      setState(() {
                        _isEntertainmentChecked = value ?? false;
                      });
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _saveInterests,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.pinkAccent.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text('Save Interests'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
