import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../pages/home_page.dart';
import '../pages/profile_page.dart';
import '../pages/search_page.dart';
import '../tweet_service.dart';
import 'app_drawer.dart';

class CustomNavigationBar extends StatefulWidget {
  final String title;
  final APIService apiService;

  const CustomNavigationBar({
    Key? key,
    required this.title,
    required this.apiService,
  }) : super(key: key);

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<ThemeState>(context);
    final List<Widget> pages = [
      HomePage(title: widget.title, apiService: widget.apiService),
      SearchPage(),
      ProfilePage(),
    ];
    final primaryColor = themeState.themeData.primaryColor;
    final iconColor = themeState.themeData.brightness == Brightness.dark
        ? Colors.white
        : primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text("SwiftFeed"),
        backgroundColor: themeState.themeData.brightness == Brightness.dark
            ? Colors.black
            : themeState.themeData.primaryColor,
        actions: [
          IconButton(
            icon: Icon(
              Icons.bookmark_added_outlined,
              color: themeState.themeData.brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/saved');
            },
          ),
        ],
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(
                Icons.menu,
                color: themeState.themeData.brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                // Same color as the InfosPage app bar
              ],
            ),
          ),
        ),
      ),
      drawer: AppDrawer(themeState: Provider.of<ThemeState>(context)),
      body: pages[_selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFFDABAB), // Same color as the InfosPage app bar
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                blurRadius: 3,
              ),
            ],
          ),
          child: FlashyTabBar(
            selectedIndex: _selectedIndex,
            showElevation: true,
            height: 60.0,
            iconSize: 24.0,
            animationDuration: Duration(milliseconds: 170),
            animationCurve: Curves.linear,
            backgroundColor: Color(0xFFFDABAB), // Match the container's background color
            items: [
              FlashyTabBarItem(
                icon: Icon(Icons.home, color: iconColor),
                title: const Text('Home'),
                activeColor: primaryColor,
                inactiveColor: themeState.themeData.brightness == Brightness.dark
                    ? Colors.grey[700] ?? const Color(0xffffffff)
                    : Colors.grey[400] ?? const Color(0xffffffff),
              ),
              FlashyTabBarItem(
                icon: Icon(Icons.search, color: iconColor),
                title: const Text('Search'),
                activeColor: primaryColor,
                inactiveColor: themeState.themeData.brightness == Brightness.dark
                    ? Colors.grey[700] ?? const Color(0xffffffff)
                    : Colors.grey[400] ?? const Color(0xffffffff),
              ),
              FlashyTabBarItem(
                icon: Icon(Icons.person, color: iconColor),
                title: const Text('Profile'),
                activeColor: primaryColor,
                inactiveColor: themeState.themeData.brightness == Brightness.dark
                    ? Colors.grey[700] ?? const Color(0xffffffff)
                    : Colors.grey[400] ?? const Color(0xffffffff),
              ),
            ],
            onItemSelected: (index) => setState(() => _selectedIndex = index),
          ),
        ),
      ),
    );
  }
}
