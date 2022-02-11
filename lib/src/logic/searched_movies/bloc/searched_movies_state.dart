part of 'searched_movies_bloc.dart';

abstract class SearchedMoviesState extends Equatable {
  const SearchedMoviesState();
  // final List<SearchedMovie> searchedMovies;

  @override
  List<Object> get props => [];
}

class SearchedMoviesInitial extends SearchedMoviesState {}

class SearchedMoviesLoading extends SearchedMoviesState {}

class SearchedMoviesLoaded extends SearchedMoviesState {
  final List<SearchedMovie> searchedMovies;

  const SearchedMoviesLoaded({required this.searchedMovies});
}

class SearchedMoviesError extends SearchedMoviesState {}
