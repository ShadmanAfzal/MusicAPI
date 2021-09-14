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
    else if (changeTheme == "orange") theme = orangeTheme;
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
    String string_theme = _prefs.getString("theme") ?? "dark";

    if (string_theme == "dark")
      theme = dark;
    else if (string_theme == "light")
      theme = light;
    else if (string_theme == "orange") theme = orangeTheme;
    notifyListeners();
  }

  _savePrefs(String string_theme) async {
    await _initPrefs();
    _prefs.setString("theme", string_theme);
  }
}
