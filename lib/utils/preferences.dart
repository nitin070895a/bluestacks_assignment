
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {

  static const String _isLoggedIn = "isLoggedIn";

  static void setLoggedIn(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isLoggedIn, isLoggedIn);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedIn) ?? false;
  }
}