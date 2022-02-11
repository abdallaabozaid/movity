part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  const ThemeState({required this.themeData, required this.themeName});
  final ThemeData themeData;
  final String themeName;
  @override
  List<Object> get props => [themeData];
}

// class ThemeInitial extends ThemeState {}

// class Theme extends ThemeState {}

// class Theme extends ThemeState {}

// class Theme extends ThemeState {}

// class Theme extends ThemeState {}
