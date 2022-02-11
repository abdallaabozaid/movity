import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movity/config/app_themes/app_themes.dart';
import 'package:movity/config/enums.dart';
import 'package:movity/src/logic/preferences/theme/app_theme_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(
          ThemeState(
            themeData: appThemeData[ThemePreferences.getSavedTheme()]!,
            themeName: ThemePreferences.getSavedTheme().toString(),
          ),
        ) {
    on<ThemeEvent>(
      (event, emit) {
        if (event is ChangeTheme) {
          ThemePreferences.saveLocalTheme(event.appTheme);
          emit(ThemeState(
              themeData: appThemeData[event.appTheme]!,
              themeName: event.appTheme.toString()));
        }
      },
    );
  }
}
