import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../category/category.dart'; // Import the Category class

class InterestPage extends StatefulWidget {
  final String id; // Add id parameter

  const InterestPage({Key? key, required this.id}) : super(key: key); // Update constructor to accept id

  @override
  _InterestPageState createState() => _InterestPageState();
}

class _InterestPageState extends State<InterestPage> {
  final List<Category> _categories = [
    Category(name: 'Arts', icon: Icons.palette),
    Category(name: 'News', icon: Icons.article),
    Category(name: 'Business', icon: Icons.business_center),
    Category(name: 'Celebrity', icon: Icons.star),
    Category(name: 'Daily Life', icon: Icons.wb_sunny),
    Category(name: 'Family', icon: Icons.family_restroom),
    Category(name: 'Fashion', icon: Icons.checkroom),
    Category(name: 'Film & TV', icon: Icons.movie),
    Category(name: 'Fitness', icon: Icons.fitness_center),
    Category(name: 'Food', icon: Icons.restaurant),
    Category(name: 'Gaming', icon: Icons.videogame_asset),
    Category(name: 'Education', icon: Icons.school),
    Category(name: 'Music', icon: Icons.music_note),
    Category(name: 'Hobbies', icon: Icons.brush),
    Category(name: 'Relationships', icon: Icons.favorite),
    Category(name: 'Science', icon: Icons.science),
    Category(name: 'Sports', icon: Icons.sports),
    Category(name: 'Travel', icon: Icons.travel_explore),
    Category(name: 'Youth', icon: Icons.child_care),
  ];

  final List<bool> _selectedCategories = List.generate(19, (_) => false);

  Future<void> _saveInterests() async {
    List<String> selectedInterests = [];
    for (int i = 0; i < _selectedCategories.length; i++) {
      if (_selectedCategories[i]) {
        selectedInterests.add(_categories[i].name);
      }
    }

    if (selectedInterests.isNotEmpty) {
      // Save selected interests to Firebase
      try {
        await FirebaseFirestore.instance.collection('users').doc(widget.id).update({
          'interests': selectedInterests,
        });

        // Save selected interests to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setStringList('interests', selectedInterests);

        // Navigate to HomePage or another page as needed
        Navigator.pushNamed(
          context,
          '/home',
          arguments: selectedInterests, // Pass selected interests as arguments
        );
      } catch (e) {
        print('Error saving interests: $e');
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Please select at least one category.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
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
      body: Container(
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
        // Use the same background color as WelcomePage
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Text(
                "Choose your Interests",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Follow Topics to influence the Swifties you see',
                style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2 / 2.5,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategories[index] = !_selectedCategories[index];
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: _selectedCategories[index]
                              ? const Color(0xFFD99D9F) // Baby pink color
                              : Colors.grey[200],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _categories[index].icon,
                              size: 40,
                              color: _selectedCategories[index]
                                  ? Colors.white
                                  : Colors.grey[700],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _categories[index].name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _selectedCategories[index]
                                    ? Colors.white
                                    : Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: _saveInterests,
                  child: const Text(
                    'Build My Feed',
                    style: TextStyle(fontSize: 20, color: Colors.white60), // Set text color to pink[400]
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white70, backgroundColor: const Color(
                      0xFFC97A7C), // Set text color to pink[400]
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
