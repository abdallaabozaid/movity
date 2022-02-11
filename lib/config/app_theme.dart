import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movity/config/colors.dart';

class AppTheming {
  static ThemeData appTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.bg,
    fontFamily: 'Crete Round',
    // textTheme: const TextTheme(
    //   bodyText1: TextStyle(fontSize: 10, color: Colors.red),
    //   headline1: TextStyle(fontSize: 50, color: Colors.white),
    // ),
    primaryColor: Colors.redAccent,
    navigationBarTheme:
        const NavigationBarThemeData(backgroundColor: Colors.white),
  );

  static SystemUiOverlayStyle systemStyle = const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
  );

  static BorderRadiusGeometry appBorderRadius = const BorderRadius.only(
      bottomLeft: Radius.circular(0),
      bottomRight: Radius.circular(20),
      topLeft: Radius.circular(20),
      topRight: Radius.circular(0));

  static InputBorder focusedBorder = const OutlineInputBorder(
    gapPadding: 4,
    borderSide: BorderSide(color: Colors.white24),
    borderRadius: BorderRadius.all(
      Radius.circular(12),
    ),
  );

  static InputBorder errorBorder = const OutlineInputBorder(
    gapPadding: 4,
    borderSide: BorderSide(color: Colors.red),
    borderRadius: BorderRadius.all(
      Radius.circular(12),
    ),
  );

  static InputBorder disabledBorder = const OutlineInputBorder(
    gapPadding: 4,
    borderSide: BorderSide(color: Colors.grey),
    borderRadius: BorderRadius.all(
      Radius.circular(12),
    ),
  );

  static InputBorder enabledBorder = const OutlineInputBorder(
    gapPadding: 4,
    borderSide: BorderSide(color: Colors.white12),
    borderRadius: BorderRadius.all(
      Radius.circular(12),
    ),
  );

  static InputDecoration inputDecoration(
      {labelText, bool passField = false, bool isObscure = true}) {
    return InputDecoration(
      labelStyle: const TextStyle(
        fontSize: 16,
        color: Color(0xffA9885B),
      ),
      suffixIcon: passField
          ? IconButton(
              onPressed: () {},
              icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off))
          : Container(),
      labelText: labelText,
      contentPadding: const EdgeInsets.all(20),
      focusedBorder: AppTheming.focusedBorder,
      enabledBorder: AppTheming.enabledBorder,
    );
  }
}
