import 'dart:convert';

import 'package:movity/src/data/model/moveis/movie_model.dart';
import 'package:movity/src/data/model/moveis/movies_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoviePreferences {
  static late SharedPreferences _preferences;

  static const _movie = 'movie';

  // initializing the user preferences
  static Future<void> initializeMoviePreferences() async =>
      _preferences = await SharedPreferences.getInstance();

  // converting json to string

  // saving the user model >>>

  static String jsonToString(Map<String, dynamic> movieJson) {
    final moviesString = json.encode(movieJson);
    backTojson(moviesString);

    return moviesString;
  }

  static Map<String, dynamic> backTojson(String movieDataInString) {
    final jsonData = json.decode(movieDataInString);

    return jsonData;
  }

  static Future<void> saveLocalTopMovies(
      Map<String, dynamic> movieItemsJson, Movie movie) async {
    final stringMovie = jsonToString(movieItemsJson);
    await _preferences.setString(movie.id, stringMovie);
  }

  static List<MovieItem>? getSavedTopMovies(Movie movie) {
    final String? moviesDataInString = _preferences.getString(movie.id);

    if (moviesDataInString == null) {
      return null;
    } else {
      final moviesLocalJson = backTojson(moviesDataInString);

      final topMoviesRepo = Movies.fromJson(moviesLocalJson);

      return topMoviesRepo.items;
    }
  }

  static Future<void> removeTopMovies(Movie movie) async {
    _preferences.remove(movie.id);
  }
}
