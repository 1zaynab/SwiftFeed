import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const String firstBootKey = 'isFirstBoot';

  static Future<bool> isFirstBoot() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(firstBootKey) ?? true; // Default to true if not set
  }

  static Future<void> setFirstBoot(bool isFirstBoot) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(firstBootKey, isFirstBoot);
  }
}
