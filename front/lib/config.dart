import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;

const apiKeyHeader = String.fromEnvironment("KYLEDLE_API_KEY_HEADER");
const apiKey = String.fromEnvironment("KYLEDLE_API_KEY");

late SharedPreferences prefs;

Future<void> loadConfigData() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  prefs = await SharedPreferences.getInstance();
}
