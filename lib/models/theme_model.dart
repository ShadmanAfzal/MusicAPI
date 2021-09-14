import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum DynamicTheme { Dark, Light, Orange }

ThemeData light = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.indigo,
    accentColor: Colors.indigo,
    scaffoldBackgroundColor: Colors.white);

ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.teal,
  accentColor: Colors.teal,
);

ThemeData orangeTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.teal,
  scaffoldBackgroundColor: Colors.white,
  accentColor: Colors.teal,
);
