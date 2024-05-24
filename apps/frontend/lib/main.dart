import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nearfleet_app/config/di/di.dart';

import './config/router/app_router.dart';
import './config/theme/app_theme.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Nearfleet App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getTheme(),
      routerConfig: appRouter,
    );
  }
}