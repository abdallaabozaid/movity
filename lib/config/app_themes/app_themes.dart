import 'package:flutter/material.dart';
import 'package:movity/config/colors.dart';
import 'package:movity/config/enums.dart';

class AppThemeClass {
  static final appThemeData = {
    AppTheme.lightBrown: ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.goldenColor,
    ),
    AppTheme.darkBrown: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
    ),
    AppTheme.lightBlue: ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.blueGrey,
    ),
    AppTheme.darkBlue: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.blue[700],
    ),
  };
}

final Map<AppTheme, ThemeData> appThemeData = {
  AppTheme.lightBrown: ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Crete Round',
    scaffoldBackgroundColor: AppColors.goldenColor,
    drawerTheme: const DrawerThemeData(
      backgroundColor: Colors.transparent,
    ),
  ),
  AppTheme.darkBrown: ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Crete Round',
    drawerTheme: const DrawerThemeData(
      backgroundColor: Colors.transparent,
    ),
    scaffoldBackgroundColor: Colors.black,
  ),
  AppTheme.lightBlue: ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Crete Round',
    drawerTheme: const DrawerThemeData(
      backgroundColor: Colors.transparent,
    ),
    scaffoldBackgroundColor: Colors.blueGrey,
  ),
  AppTheme.darkBlue: ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Crete Round',
    drawerTheme: const DrawerThemeData(
      backgroundColor: Colors.transparent,
    ),
    scaffoldBackgroundColor: Colors.blue[700],
  ),
};
