import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../pages/interest_page.dart';
import '../themeapp/Infos.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key, required this.themeState}) : super(key: key);

  final ThemeState themeState;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent, // Light blue
              Color(0xFFFDABAB), // Darker blue
            ],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero, // Remove padding to remove the thin line
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent, // Darker blue
                  ],
                ),
              ),
              child: FutureBuilder<Map<String, dynamic>>(
                future: _getProfileData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text('Error loading profile data');
                  } else {
                    final profileData = snapshot.data!;
                    // Get the current theme's text color
                    final textColor = themeState.themeData.brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black54;
                    // Define the circle text color based on the theme
                    final circleTextColor = themeState.themeData.brightness == Brightness.dark
                        ? themeState.themeData.primaryColor
                        : const Color(0xFFFDABAB); // Pink color for light mode
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome ${profileData['name']}',
                          style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: CircleAvatar(
                            radius: 49,
                            backgroundColor: Colors.white70,
                            child: Text(
                              profileData['name'].isNotEmpty ? profileData['name'][0].toUpperCase() : '',
                              style: TextStyle(
                                fontSize: 36,
                                color: circleTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
            // Reordered ListTiles
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent, // Light blue
                            Color(0xFFFDABAB), // Darker blue
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.person),
                            title: const Text('Update Your Profile'),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => InfosPage()),
                              );
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.interests),
                            title: const Text('Update Your Interests'),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FutureBuilder<Map<String, dynamic>>(
                                    future: _getProfileData(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return const Text('Error loading profile data');
                                      } else {
                                        final profileData = snapshot.data!;
                                        return InterestPage(id: profileData['id']);
                                      }
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            ListTile(
              leading: themeState.themeData.brightness == Brightness.dark
                  ? const Icon(Icons.brightness_3_rounded) // Moon icon for dark mode
                  : const Icon(Icons.brightness_5_outlined), // Sun icon for light mode
              title: const Text('Dark Mode'),
              trailing: Switch(
                value: themeState.themeData.brightness == Brightness.dark,
                onChanged: (newValue) => themeState.toggleTheme(),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
}
