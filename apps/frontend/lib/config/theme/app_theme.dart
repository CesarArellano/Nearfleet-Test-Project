import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme();

  static ThemeData getTheme() {
    return ThemeData(
      colorSchemeSeed: const Color.fromARGB(255, 69, 239, 191),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 31, 238, 179)
      ),
      scaffoldBackgroundColor: Colors.white,
    );
  }
}