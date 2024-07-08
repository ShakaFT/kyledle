import 'package:intl/intl.dart';
import 'package:kyledle/config.dart';
import 'package:timezone/standalone.dart' as tz;

Future<List<String>> getAttempts(String game, String mode) async {
  final lastUpdate = prefs.getString('${game}_${mode}_last_update');
  final now = _castDateTime(_nowMidnight());

  if (lastUpdate != null &&
      now.isAfter(_castDateTime(DateTime.parse(lastUpdate)))) {
    await clearAttempts(game, mode);
  }

  return prefs.getStringList('${game}_${mode}_attempts') ?? [];
}

Future<void> setAttempts(
  String game,
  String mode,
  List<String> attempts,
) async {
  await prefs.setStringList('${game}_${mode}_attempts', attempts);
  await prefs.setString(
    '${game}_${mode}_last_update',
    DateFormat('yyyy-MM-dd').format(_castDateTime(_nowMidnight())),
  );
}

Future<void> clearAttempts(String game, String mode) async {
  await prefs.remove('${game}_${mode}_attempts');
  await prefs.remove('${game}_${mode}_last_update');
}

tz.TZDateTime _castDateTime(DateTime datetime) {
  final paris = tz.getLocation("Europe/Paris");
  return tz.TZDateTime.from(datetime, paris);
}

DateTime _nowMidnight() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
}
