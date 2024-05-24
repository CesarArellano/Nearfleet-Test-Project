import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme();

  ThemeData getTheme() {
    return ThemeData(
      colorSchemeSeed: Colors.blueAccent,
      brightness: Brightness.dark
    );
  }
}