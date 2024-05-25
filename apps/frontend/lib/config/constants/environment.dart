import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String baseURL = (Platform.isAndroid)
    ? dotenv.env['BASE_URL_FOR_ANDROID_ONLY'] ?? 'http://:10.0.2.2:8000/api'
    : dotenv.env['BASE_URL'] ?? 'http://localhost:8000/api';
}