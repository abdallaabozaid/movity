import 'dart:convert';

import 'package:movity/src/data/model/moveis/movies_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

class TopMoviesPreferences {
  static late SharedPreferences _preferences;

  static const _movieList = 'movies-list';
  static const _mostPopular = 'most-popular-movis';

  // initializing the user preferences
  static Future<void> initializeTopMoviesPreferences() async =>
      _preferences = await SharedPreferences.getInstance();

  // converting json to string

  // saving the user model >>>

  static String jsonToListOfStrings(Map<String, dynamic> movieItemsJson) {
    final moviesStrings = json.encode(movieItemsJson);
    // backTojson(moviesStrings);

    return moviesStrings;
  }

  static Map<String, dynamic> backTojson(String moviesDataInString) {
    final jsonData = json.decode(moviesDataInString);

    return jsonData;
  }

  static Future<void> saveLocalTopMovies(
      Map<String, dynamic> movieItemsJson) async {
    final stringMovies = jsonToListOfStrings(movieItemsJson);
    await _preferences.setString(_movieList, stringMovies);
  }

  static Future<void> saveLocalMostPopularMovies(
      Map<String, dynamic> movieItemsJson) async {
    final stringMovies = jsonToListOfStrings(movieItemsJson);
    await _preferences.setString(_mostPopular, stringMovies);
  }

  static List<MovieItem>? getSavedTopMovies() {
    final String? moviesDataInString = _preferences.getString(_movieList);

    if (moviesDataInString == null) {
      return null;
    } else {
      final moviesLocalJson = backTojson(moviesDataInString);

      final topMoviesRepo = Movies.fromJson(moviesLocalJson);

      return topMoviesRepo.items;
    }
  }

  static List<MovieItem>? getSavedMostPopularMovies() {
    final String? moviesDataInString = _preferences.getString(_mostPopular);

    if (moviesDataInString == null) {
      return null;
    } else {
      final moviesLocalJson = backTojson(moviesDataInString);

      final mostPopularMoviesRepo = Movies.fromJson(moviesLocalJson);

      return mostPopularMoviesRepo.items;
    }
  }

  static Future<void> removeMovies() async {
    await _preferences.remove(_movieList);
    await _preferences.remove(_mostPopular);
  }
}
