import 'package:shared_preferences/shared_preferences.dart';

class ThemeSharedPreferences {
  final themeStatus = "status";

  Future<void> setThemePref(bool x) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(themeStatus, x);
  }

  Future<bool> getThemePref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(themeStatus) ?? false;
  }
}
