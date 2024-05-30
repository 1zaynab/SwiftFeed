import 'package:final_project/pages/saved_page.dart';
import 'package:final_project/pages/search_page.dart';
import 'package:final_project/pages/welcome.dart';
import 'package:final_project/screens/custom_navigation_bar.dart';
import 'package:final_project/themeapp/Infos.dart';
import 'package:final_project/themeapp/appthemes.dart';
import 'package:final_project/themeapp/shared-pref.dart';
import 'package:final_project/tweet_service.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'category/selected_categories.dart';
import 'classes/article_provider.dart';
 // Import InfosPage

// ThemeState class for managing theme data
class ThemeState extends ChangeNotifier {
  ThemeData _themeData = AppThemes.lightTheme;

  ThemeData get themeData => _themeData;

  void toggleTheme() {
    _themeData = _themeData == AppThemes.lightTheme ? AppThemes.darkTheme : AppThemes.lightTheme;
    notifyListeners();
  }
}

// ThemeProvider class for managing dark and light theme
class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeState()),
        ChangeNotifierProvider(create: (context) => SelectedCategories()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => ArticleProvider()),
        Provider(create: (context) => APIService(baseUrl: 'http://10.0.2.2:5000')),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  final APIService apiService = APIService(baseUrl: 'http://10.0.2.2:5000');

  MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<bool>? _isFirstBoot;

  @override
  void initState() {
    super.initState();
    _isFirstBoot = SharedPrefs.isFirstBoot();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<ThemeState>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Combined App',
      theme: themeProvider.isDarkMode ? ThemeData.dark() : themeState.themeData,
      home: FutureBuilder<bool>(
        future: _isFirstBoot,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Or any loading indicator
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final isFirstBoot = snapshot.data ?? true;
            return isFirstBoot ? WelcomePage() : MyHomePage(name: 'Twitter Feed', apiService: widget.apiService);
          }
        },
      ),
      routes: {
        '/home': (context) => MyHomePage(
          name: 'Twitter Feed',
          apiService: widget.apiService,
        ),
        '/search': (context) => SearchPage(),
        '/saved': (context) => SavedPage(),
        '/welcome': (context) => WelcomePage(),
        '/infos': (context) => const InfosPage(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String name;
  final APIService apiService;

  MyHomePage({super.key, required this.name, required this.apiService});

  @override
  Widget build(BuildContext context) {
    return CustomNavigationBar(title: name, apiService: apiService);
  }
}

