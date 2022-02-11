part of 'movies_cubit.dart';

@immutable
abstract class MoviesState {}

class MoviesInitial extends MoviesState {}

class LoadedTopMovis extends MoviesState {
  final List<MovieItem>? topmovieItems;
  final List<MovieItem>? popularMovieItems;

  LoadedTopMovis(
      {required this.topmovieItems, required this.popularMovieItems});
}

class LoadingMovies extends MoviesState {
  final bool isLoading;

  LoadingMovies(this.isLoading);
}
