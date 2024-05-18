import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatelessWidget {
  Future<Map<String, dynamic>> _getProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('id') ?? '';
    final name = prefs.getString('name') ?? '';
    final age = prefs.getInt('age') ?? 0;
    final city = prefs.getString('city') ?? '';
    final interests = prefs.getStringList('interests') ?? [];

    return {
      'id': id,
      'name': name,
      'age': age,
      'city': city,
      'interests': interests,
    };
  }

  Future<void> _fetchDataFromFirebase(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('id') ?? '';
    final userData = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (userData.exists) {
      prefs.setString('name', userData['name']);
      prefs.setInt('age', userData['age']);
      prefs.setString('city', userData['city']);
      prefs.setStringList('interests', List<String>.from(userData['interests']));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data updated from Firebase')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to fetch data from Firebase')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _getProfileData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
              backgroundColor: Colors.pink.shade100,
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
              backgroundColor: Colors.pink.shade100,
            ),
            body: const Center(
              child: Text('Error loading profile data'),
            ),
          );
        } else {
          final profileData = snapshot.data!;
          return Scaffold(
            backgroundColor: Colors.pink.shade50,
            appBar: AppBar(
              title: Text(
                'Welcome ${profileData['name']}',
                style: const TextStyle(color: Colors.pink),
              ),
              backgroundColor: Colors.pink.shade100,
              automaticallyImplyLeading: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        child: Text(
                          profileData['name'].isNotEmpty ? profileData['name'][0] : '',
                          style: const TextStyle(fontSize: 36, color: Colors.white),
                        ),
                        backgroundColor: Colors.pinkAccent.shade700,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Text(
                            'ID: ',
                            style: TextStyle(fontSize: 20, color: Colors.pink, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            profileData['id'],
                            style: const TextStyle(fontSize: 20, color: Colors.pinkAccent),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Name: ',
                            style: TextStyle(fontSize: 20, color: Colors.pink, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            profileData['name'],
                            style: const TextStyle(fontSize: 20, color: Colors.pinkAccent),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Age: ',
                            style: TextStyle(fontSize: 20, color: Colors.pink, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            profileData['age'].toString(),
                            style: const TextStyle(fontSize: 20, color: Colors.pinkAccent),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'City: ',
                            style: TextStyle(fontSize: 20, color: Colors.pink, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            profileData['city'],
                            style: const TextStyle(fontSize: 20, color: Colors.pinkAccent),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Interests: ',
                            style: TextStyle(fontSize: 20, color: Colors.pink, fontWeight: FontWeight.bold),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: (profileData['interests'] as List<String>)
                                .map((interest) => Text(
                              '- $interest',
                              style: const TextStyle(fontSize: 18, color: Colors.pinkAccent),
                            ))
                                .toList(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          _fetchDataFromFirebase(context);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.pinkAccent.shade700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Text('Update Your Profile'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
