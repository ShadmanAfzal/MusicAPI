import 'package:appyhigh_assignment_flutter/models/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  SharedPreferences _prefs;
  ThemeData theme;

  changeTheme(String changeTheme) {
    if (changeTheme == "dark")
      theme = dark;
    else if (changeTheme == "light")
      theme = light;
    else if (changeTheme == "teal") theme = teal;
    _savePrefs(changeTheme);
    notifyListeners();
  }

  ThemeNotifier() {
    theme = dark;
    _loadPrefs();
  }

  _initPrefs() async {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
  }

  _loadPrefs() async {
    await _initPrefs();
    String stringTheme = _prefs.getString("theme") ?? "dark";

    if (stringTheme == "dark")
      theme = dark;
    else if (stringTheme == "light")
      theme = light;
    else if (stringTheme == "teal") theme = teal;
    notifyListeners();
  }

  _savePrefs(String stringtheme) async {
    await _initPrefs();
    _prefs.setString("theme", stringtheme);
  }
}
