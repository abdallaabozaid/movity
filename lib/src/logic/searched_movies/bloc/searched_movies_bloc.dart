import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movity/src/data/model/moveis/searched_movies_model.dart';
import 'package:movity/src/data/repo/searched_movie_repo.dart';

part 'searched_movies_event.dart';
part 'searched_movies_state.dart';

class SearchedMoviesBloc
    extends Bloc<SearchedMoviesEvent, SearchedMoviesState> {
  final SearchedMoviesRepo searchedMoviesRepo;
  SearchedMoviesBloc(this.searchedMoviesRepo) : super(SearchedMoviesInitial()) {
    on<SearchedMoviesEvent>(
      (event, emit) async {
        if (event is GetSearchedMovies) {
          print('in the bloc');
          emit(SearchedMoviesLoading());
          final resultMovies = await searchedMoviesRepo
              .creatSearchedMoviesRepo(event.searchWord);

          if (resultMovies == null) {
            emit(SearchedMoviesError());
          } else {
            emit(SearchedMoviesLoaded(searchedMovies: resultMovies));
          }
        }
      },
    );
  }
}
