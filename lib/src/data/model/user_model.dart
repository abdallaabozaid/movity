import 'dart:io';

import 'package:movity/src/data/model/moveis/movie_model.dart';

abstract class BaseUser {
  final String? uid;
  final bool? isAnon;
  final bool? isNew;

  final File? headerImageFile;
  final File? profileImageFile;

  final String? email;
  final String? profileImgUrl;
  final String? firstName;
  final String? lastName;

  final String? bestQuote;
  final int? watched;
  final int? toWatch;
  final List<ActorList> favoriteActors;
  final List<Movie> favoriteMovies;
  final List<Movie> toWatchMovies;

  final List<Movie> watchedMovies;

  BaseUser({
    required this.uid,
    required this.isAnon,
    required this.isNew,
    required this.profileImageFile,
    required this.headerImageFile,
    required this.email,
    required this.profileImgUrl,
    required this.firstName,
    required this.lastName,
    required this.bestQuote,
    required this.toWatch,
    required this.watched,
    required this.favoriteActors,
    required this.favoriteMovies,
    required this.toWatchMovies,
    required this.watchedMovies,
  });
}

class UserModel implements BaseUser {
  @override
  final String uid;
  @override
  final bool isAnon;
  @override
  final bool? isNew;
  @override
  File? headerImageFile;
  @override
  File? profileImageFile;
  @override
  String email;
  @override
  String profileImgUrl;
  @override
  String firstName;
  @override
  String lastName;

  @override
  String bestQuote;
  @override
  int watched;
  @override
  int toWatch;
  @override
  List<ActorList> favoriteActors;
  @override
  List<Movie> favoriteMovies;
  @override
  List<Movie> toWatchMovies;
  @override
  List<Movie> watchedMovies;

  UserModel({
    required this.uid,
    this.isNew = false,
    this.headerImageFile,
    this.profileImageFile,
    required this.isAnon,
    required this.email,
    required this.profileImgUrl,
    required this.firstName,
    required this.lastName,
    this.bestQuote = '',
    this.watched = 0,
    this.toWatch = 0,
    required this.favoriteMovies,
    required this.favoriteActors,
    required this.toWatchMovies,
    required this.watchedMovies,
  });
}
