part of 'movie_cubit.dart';

@immutable
abstract class MovieState {}

class MovieInitial extends MovieState {}

class LoadingMovie extends MovieState {
  final bool isLoading;

  LoadingMovie(this.isLoading);
}

class LoadedMovie extends MovieState {
  final Movie movie;

  LoadedMovie(this.movie);
}

class LoadingMovieError extends MovieState {
  final String errorMessage;

  LoadingMovieError(this.errorMessage);
}
