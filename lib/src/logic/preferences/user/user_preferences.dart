import 'dart:convert';
import 'dart:io';

import 'package:movity/src/data/model/moveis/movie_model.dart';
import 'package:movity/src/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences _preferences;

  static const _uidKey = 'uid';
  static const _firstName = 'firstName';
  static const _lastName = 'lastName';
  static const _isAnon = 'isAnon';
  static const _email = 'email';
  static const _profileImgUrl = 'profileImgUrl';
  static const _headerImagePath = 'headerImagePath';
  static const _profileImagePath = 'profileImagePath';
  static const _bestQuote = 'bestQuote';
  static const _watched = 'watched';
  static const _toWatch = 'toWatch';
  static const _favMovies = 'favMovies';
  static const _favActors = 'favActors';
  static const _toWatchMovies = 'toWatchMovies';
  static const _watchedMovies = 'watchedMovies';

  // initializing the user preferences
  static Future<void> initializeUserPreferences() async =>
      _preferences = await SharedPreferences.getInstance();

  // saving the user model >>>

  static String _jsonEncoderForActorList(List<ActorList> favActorList) {
    final listOfJson = favActorList.map((e) => e.toJson()).toList();
    final String favActorsToString = json.encode(listOfJson);

    return favActorsToString;
  }

  static String jsonEncoderForMoviesList(List<Movie> favMovieLsist) {
    final listOfJson = favMovieLsist.map((e) => e.toJson()).toList();

    final String favMoviesToString = json.encode(listOfJson);

    return favMoviesToString;
  }

  static Future<void> saveLocalUserModel(UserModel userModel) async {
    final favMoviesString = jsonEncoderForMoviesList(userModel.favoriteMovies);
    final favActorsString = _jsonEncoderForActorList(userModel.favoriteActors);
    final toWatchMoviesString =
        jsonEncoderForMoviesList(userModel.toWatchMovies);
    final watchedMoviesString =
        jsonEncoderForMoviesList(userModel.watchedMovies);
    await _preferences.setString(_uidKey, userModel.uid);
    await _preferences.setString(_email, userModel.email);
    await _preferences.setString(_firstName, userModel.firstName);
    await _preferences.setString(_lastName, userModel.lastName);
    await _preferences.setString(_profileImgUrl, userModel.profileImgUrl);
    await _preferences.setString(_bestQuote, userModel.bestQuote);
    await _preferences.setInt(_watched, userModel.watched);
    await _preferences.setInt(_toWatch, userModel.toWatch);
    await _preferences.setBool(_isAnon, userModel.isAnon);

    userModel.profileImageFile != null
        ? await _preferences.setString(
            _profileImagePath, userModel.profileImageFile!.path)
        : null;

    userModel.headerImageFile != null
        ? await _preferences.setString(
            _headerImagePath,
            userModel.headerImageFile!.path,
          )
        : null;

    await _preferences.setString(_favMovies, favMoviesString);
    await _preferences.setString(_favActors, favActorsString);
    await _preferences.setString(_toWatchMovies, toWatchMoviesString);

    await _preferences.setString(_watchedMovies, watchedMoviesString);
  }

  static List<ActorList> backToActorList(String? listInString) {
    if (listInString == null) {
      return [];
    } else {
      final jsonData = json.decode(listInString) as List;
      final backFaveActorList =
          jsonData.map((e) => ActorList.fromJson(e)).toList();

      return backFaveActorList;
    }
  }

  static List<Movie> backToMoviesList(String? listInString) {
    if (listInString == null) {
      return [];
    } else {
      final jsonData = json.decode(listInString) as List;
      final backFaveMoviesList =
          jsonData.map((e) => Movie.fromJson(e)).toList();

      return backFaveMoviesList;
    }
  }

  static UserModel? getLocalUserModel() {
    final String? uid = _preferences.getString(_uidKey);
    final String? email = _preferences.getString(_email);
    final String? firstName = _preferences.getString(_firstName);
    final String? lastName = _preferences.getString(_lastName);
    final String? profileImgUrl = _preferences.getString(_profileImgUrl);
    final String? bestQuote = _preferences.getString(_bestQuote);
    final int? watched = _preferences.getInt(_watched);
    final int? toWatch = _preferences.getInt(_toWatch);
    final bool? isAnon = _preferences.getBool(_isAnon);
    final String? profileImagePath = _preferences.getString(_profileImagePath);
    final String? headerImagePath = _preferences.getString(_headerImagePath);
    final String? favActorListInString = _preferences.getString(_favActors);
    final String? favMoviesListInString = _preferences.getString(_favMovies);
    final String? toWatchMoviesListInString =
        _preferences.getString(_toWatchMovies);
    final String? watchedMoviesListInString =
        _preferences.getString(_watchedMovies);

    if (uid == null) {
      return null;
    } else {
      List<ActorList> favActorList = [];
      List<Movie> favMoviesList = [];
      List<Movie> toWatchMoviesList = [];
      List<Movie> watchedMoviesList = [];

      favActorList = backToActorList(favActorListInString);
      toWatchMoviesList = backToMoviesList(toWatchMoviesListInString);

      watchedMoviesList = backToMoviesList(watchedMoviesListInString);

      favMoviesList = backToMoviesList(favMoviesListInString);

      return UserModel(
        uid: uid,
        isAnon: isAnon!,
        email: email!,
        profileImgUrl: profileImgUrl!,
        firstName: firstName!,
        lastName: lastName!,
        bestQuote: bestQuote!,
        watched: watched!,
        toWatch: toWatch!,
        profileImageFile:
            profileImagePath == null ? null : File(profileImagePath),
        headerImageFile: headerImagePath == null ? null : File(headerImagePath),
        favoriteActors: favActorList,
        favoriteMovies: favMoviesList,
        toWatchMovies: toWatchMoviesList,
        watchedMovies: watchedMoviesList,
      );
    }
  }

  static Future<void> removeLocalUserModel() async {
    _preferences.remove(_uidKey);
    _preferences.remove(_email);
    _preferences.remove(_firstName);
    _preferences.remove(_lastName);
    _preferences.remove(_profileImgUrl);
    _preferences.remove(_isAnon);
    _preferences.remove(_bestQuote);
    _preferences.remove(_watched);
    _preferences.remove(_toWatch);
    _preferences.remove(_headerImagePath);
    _preferences.remove(_profileImagePath);
    _preferences.remove(_favActors);
    _preferences.remove(_favMovies);
    _preferences.remove(_toWatchMovies);
    _preferences.remove(_watchedMovies);
  }
}
