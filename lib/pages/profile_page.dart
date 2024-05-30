import 'package:finalapp/classes/article.dart';
import 'package:finalapp/classes/article_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../classes/article_provider.dart';


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
    final userData =
    await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (userData.exists) {
      prefs.setString('name', userData['name']);
      prefs.setInt('age', userData['age']);
      prefs.setString('city', userData['city']);
      prefs.setStringList(
          'interests', List<String>.from(userData['interests']));
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
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text('Error loading profile data'),
            ),
          );
        } else {
          final profileData = snapshot.data!;
          final interests = profileData['interests'] as List<String>;

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
                        Colors.transparent, // Start with a light color
                        Color(0xFFFDABAB), // End with a darker color
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: const Color(0xFFFDABAB)
                                .withOpacity(
                                0.5), // Set background color with opacity
                            child: Text(
                              profileData['name'][0]
                                  .toUpperCase(),
                              // Get the first letter of the name and capitalize it
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white, // Set text color
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            profileData['name'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            profileData['id'], // Use the user's ID
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Card(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              color: Colors.white
                                  .withOpacity(0.7), // Set the opacity here
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          '${snapshot.data?['age']}',
                                          // Age from shared preferences
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Text('Age'),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          '${snapshot.data?['city']}',
                                          // City from shared preferences
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Text('City'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Favorites',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Consumer<ArticleProvider>(
                              builder: (context, articleProvider, child) {
                                final likedArticles =
                                    articleProvider.likedArticles;

                                if (likedArticles.isEmpty) {
                                  return const Text('No liked News.');
                                }

                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: likedArticles.map((article) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: _buildArticleCard(
                                            context, article as Article),
                                      );
                                    }).toList(),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Interests',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 15,
                              children: profileData['interests']
                                  .map<Widget>((interest) {
                                return Chip(
                                  label: Text(interest),
                                  backgroundColor: const Color(0xFFC97A7C),
                                  labelStyle: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 20,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide.none,
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildArticleCard(BuildContext context, Article article) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetailPage(article: article),
          ),
        );
      },
      child: Container(
        width: article.tweetImage.isNotEmpty
            ? 200
            : 150, // Adjust width based on image presence
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
          image: article.tweetImage.isNotEmpty
              ? DecorationImage(
            image: NetworkImage(article.tweetImage),
            fit: BoxFit.cover,
          )
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              const SizedBox(height: 15),
              Text(
                article.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  backgroundColor: Colors.white.withOpacity(0.4),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                article.content,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  backgroundColor: Colors.white.withOpacity(0.4),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTagChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.pinkAccent,
      labelStyle: const TextStyle(
        color: Colors.white,
      ),
    );
  }
}