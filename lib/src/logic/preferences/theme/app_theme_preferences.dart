import 'package:movity/config/enums.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static late SharedPreferences _preferences;

  static const _theme = 'theme';

  // initializing the user preferences
  static Future<void> initializeThemePreferences() async =>
      _preferences = await SharedPreferences.getInstance();

  // saving  theme  >>>

  static String _themeToString(AppTheme appTheme) {
    final appThemeString = appTheme.toString();

    return appThemeString;
  }

  // static Map<String, dynamic> backTojson(String moviesDataInString) {
  //   final jsonData = json.decode(moviesDataInString);

  //   return jsonData;
  // }

  static Future<void> saveLocalTheme(AppTheme appTheme) async {
    final appThemeString = _themeToString(appTheme);
    await _preferences.setString(_theme, appThemeString);
  }

  static AppTheme _convertingThemeString(String? themeString) {
    if (themeString == AppTheme.darkBrown.toString()) {
      return AppTheme.darkBrown;
    } else if (themeString == AppTheme.lightBrown.toString()) {
      return AppTheme.lightBrown;
    } else if (themeString == AppTheme.darkBlue.toString()) {
      return AppTheme.darkBlue;
    } else if (themeString == AppTheme.lightBlue.toString()) {
      return AppTheme.lightBlue;
    } else {
      return AppTheme.darkBrown;
    }
  }

  static AppTheme getSavedTheme() {
    final String? themeString = _preferences.getString(_theme);

    // if (themeString == null) {
    //   return AppTheme.darkBrown;
    // } else {
    final AppTheme appTheme = _convertingThemeString(themeString);
    return appTheme;
    // }
  }

  static Future<void> removeSavedTheme() async {
    await _preferences.remove(_theme);
  }
}
