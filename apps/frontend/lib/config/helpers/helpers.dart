import 'package:flutter/material.dart';

class Helpers {
  static void showSnackbar(BuildContext context, { required String message, bool isAnErrorMessage = false}) {
    final scaffoldMesenger =  ScaffoldMessenger.of(context);
    scaffoldMesenger.clearSnackBars();
    scaffoldMesenger.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isAnErrorMessage ? Colors.redAccent :Colors.green,
      )
    );
  }
}