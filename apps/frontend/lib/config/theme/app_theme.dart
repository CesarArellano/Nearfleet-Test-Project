import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme();

  static ThemeData getTheme() {
    return ThemeData(
      colorSchemeSeed: const Color(0xFF0CCF74),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.greenAccent,
      ),
      scaffoldBackgroundColor: Colors.white,
    );
  }
}