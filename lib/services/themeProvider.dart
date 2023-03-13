import 'package:chef_recipes/services/themeSahred.dart';
import 'package:flutter/cupertino.dart';


class ThemeProvider with ChangeNotifier {
  bool _themeSts = false;
  ThemeSharedPreferences themePref = ThemeSharedPreferences();

  bool get getDarkmode => _themeSts;

  set setthemeMode(bool value) {
    _themeSts = value;
    themePref.setThemePref(value);
    notifyListeners();
  }
}
