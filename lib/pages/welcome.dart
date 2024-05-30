/*

import 'package:flutter/material.dart';

import '../themeapp/Infos.dart';


class WelcomePage extends StatelessWidget {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Optional: App name (adjust font size and color as needed)
                const Text(
                  'SwifFeed',
                  style: TextStyle(fontSize: 50.0, color: Colors.black,fontWeight:FontWeight.bold ),
                ),
                const SizedBox(height: 20.0),
                // Explore Button
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const InfosPage()),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    minimumSize: const Size(150, 150),
                    padding: const EdgeInsets.all(20.0),
                    elevation: 5.0,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    backgroundColor: Colors.pinkAccent, // Green
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Optional: News icon (adjust size as needed)
                      // Icon(Icons.newspaper, size: 20.0, color: Colors.white),
                      Text(
                        'Get Started',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
*//*





import 'package:flutter/material.dart';
import '../themeapp/Infos.dart';
import '../themeapp/shared-pref.dart';
// Import the shared preferences utility

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // App logo or name at the top
                const Padding(
                  padding: EdgeInsets.only(bottom: 50.0),
                  child: Text(
                    'SwiftFeed',
                    style: TextStyle(
                      fontSize: 50.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Prompt text
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'News, delivered swiftly',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10.0),
                // Placeholder for additional text (e.g., Lorem Ipsum)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Stay informed. Stay connected. Your community awaits.',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30.0),
                // Explore Button
                ElevatedButton(
                  onPressed: () async {
                    await SharedPrefs.setFirstBoot(false); // Update the flag
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => InfosPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    minimumSize: const Size(80, 80),
                    padding: const EdgeInsets.all(20.0),
                    elevation: 5.0,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    backgroundColor: const Color(0xFFC97A7C),
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    size: 40.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 50.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
*/



import 'package:flutter/material.dart';
import '../themeapp/Infos.dart';
import '../themeapp/shared-pref.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient overlay
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App logo or name at the top
                const Padding(
                  padding: EdgeInsets.only(bottom: 50.0),
                  child: Text(
                    'SwiftFeed',
                    style: TextStyle(
                      fontSize: 50.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Prompt text container
                Container(
                  padding: const EdgeInsets.all(20.0),
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Column(
                    children:  [
                      Text(
                        'News, delivered swiftly',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'Empower your local knowledge. News that shapes your world. ',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30.0),
                // Explore Button
                ElevatedButton(
                  onPressed: () async {
                    await SharedPrefs.setFirstBoot(false); // Update the flag
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => InfosPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    minimumSize: const Size(80, 80),
                    padding: const EdgeInsets.all(20.0),
                    elevation: 5.0,
                    shadowColor: Colors.grey.withOpacity(0.9),
                    backgroundColor: const Color(0xFFC97A7C),
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    size: 40.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 50.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
