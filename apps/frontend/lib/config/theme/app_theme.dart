import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme();

  static ThemeData getTheme() {
    return ThemeData(
      colorSchemeSeed: const Color(0xFF209BA1),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF00F2FF)
      )
    );
  }
}