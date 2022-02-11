part of 'searched_movies_bloc.dart';

abstract class SearchedMoviesEvent extends Equatable {
  const SearchedMoviesEvent();

  @override
  List<Object> get props => [];
}

class GetSearchedMovies extends SearchedMoviesEvent {
  final String searchWord;

  const GetSearchedMovies(this.searchWord);
}
