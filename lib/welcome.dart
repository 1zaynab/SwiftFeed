import 'package:finalapp/Infos.dart';
import 'package:flutter/material.dart';


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
