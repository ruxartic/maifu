import 'package:shared_preferences/shared_preferences.dart';

class SettingsUtils {
  static const String _themeKey = 'theme';
  static const String _safeKey = 'safe';
  static const String _suggestiveKey = 'suggestive';
  static const String _borderlineKey = 'borderline';
  static const String _explicitKey = 'explicit';

  // Default values
  static const bool _defaultSafe = true;
  static const bool _defaultSuggestive = true;
  static const bool _defaultBorderline = true;
  static const bool _defaultExplicit = false;

  // Setters
  static Future<void> setTheme(String theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, theme);
  }

  static Future<void> setSafe(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_safeKey, value);
  }

  static Future<void> setSuggestive(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_suggestiveKey, value);
  }

  static Future<void> setBorderline(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_borderlineKey, value);
  }

  static Future<void> setExplicit(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_explicitKey, value);
  }

  // Getters
  static Future<String> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_themeKey) ?? 'dark'; 
  }

  static Future<bool> getSafe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_safeKey) ?? _defaultSafe;
  }

  static Future<bool> getSuggestive() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_suggestiveKey) ?? _defaultSuggestive;
  }

  static Future<bool> getBorderline() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_borderlineKey) ?? _defaultBorderline;
  }

  static Future<bool> getExplicit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_explicitKey) ?? _defaultExplicit;
  }

  static Future<void> setRatingOption(String option, bool value) async {
  switch(option) {
    case 'safe':
      await setSafe(value);
      break;
    case 'suggestive':
      await setSuggestive(value);
      break;
    case 'borderline':
      await setBorderline(value);
      break;
    case 'explicit':
      await setExplicit(value);
      break;
    default:
      throw Exception('Invalid rating option: $option');
  }
}

static Future<bool> getRatingOption(String key) async {
  switch (key) {
    case 'safe':
      return await getSafe();
    case 'suggestive':
      return await getSuggestive();
    case 'borderline':
      return await getBorderline();
    case 'explicit':
      return await getExplicit();
    default:
      throw Exception('Invalid rating option key: $key');
  }
}

static Future<Map<String, bool>> getRatingOptions() async {
  final safe = await getSafe();
  final suggestive = await getSuggestive();
  final borderline = await getBorderline();
  final explicit = await getExplicit();
  
  return {
    'safe': safe,
    'suggestive': suggestive,
    'borderline': borderline,
    'explicit': explicit,
  };
}
}
