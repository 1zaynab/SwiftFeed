import 'package:finalapp/pages/home_page.dart';
import 'package:finalapp/screens/custom_navigation_bar.dart';
import 'package:finalapp/tweet_service.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


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
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: const Text(
          'Select Interests',
          style: TextStyle(color: Colors.pink),
        ),
        backgroundColor: Colors.pink.shade100,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
    );
  }
}

















/*import 'package:flutter/material.dart';

class InterestPage extends StatefulWidget {
  const InterestPage({super.key});

  @override
  _InterestPageState createState() => _InterestPageState();
}

class _InterestPageState extends State<InterestPage> {
  final List<String> _categories = ['Politics', 'Sports', 'Technology', 'Entertainment', 'Health', 'Business'];
  final List<bool> _selectedCategories = List.generate(6, (_) => false);

  void _navigateToHomePage() {
    // Check if at least two categories are selected
    List<String> selectedInterests = [];
    for (int i = 0; i < _selectedCategories.length; i++) {
      if (_selectedCategories[i]) {
        selectedInterests.add(_categories[i]);
      }
    }

    if (selectedInterests.length >= 2) {
      Navigator.pushNamed(context, '/home', arguments: selectedInterests);
    } else {
      // Show a custom dialog to prompt the user to select at least two categories
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please select at least two categories.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height:30),
            const Text(
              "Choose your topic",
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(_categories[index]),
                    value: _selectedCategories[index],
                    onChanged: (value) {
                      setState(() {
                        _selectedCategories[index] = value!;
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _navigateToHomePage,
              child: const Text('Continue',
                style: TextStyle(fontSize:40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
