import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static const String lastCheckedDateKey = 'lastCheckedDate';

  // Get the last checked date from SharedPreferences
  static Future<DateTime?> getLastCheckedDate() async {
    final prefs = await SharedPreferences.getInstance();
    String? lastCheckedDateString = prefs.getString(lastCheckedDateKey);
    if (lastCheckedDateString != null) {
      return DateTime.parse(lastCheckedDateString);
    }
    return null;
  }

  // Save the current date as the last checked date
  static Future<void> saveCurrentDate() async {
    final prefs = await SharedPreferences.getInstance();
    String currentDateString = DateTime.now().toIso8601String();
    await prefs.setString(lastCheckedDateKey, currentDateString);
  }

  // Check if the current date is different from the last checked date
  static Future<bool> isNewDay() async {
    DateTime now = DateTime.now();
    DateTime? lastCheckedDate = await getLastCheckedDate();
    if (lastCheckedDate == null) {
      // If no last checked date, consider it a new day
      return true;
    }

    // Compare only the date (year, month, day) to see if it's a new day
    return now.year != lastCheckedDate.year ||
        now.month != lastCheckedDate.month ||
        now.day != lastCheckedDate.day;
  }
}
