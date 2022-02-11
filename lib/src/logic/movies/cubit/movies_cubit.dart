import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movity/src/data/model/moveis/movies_model.dart';
import 'package:movity/src/data/repo/most_popular_movies_repo.dart';
import 'package:movity/src/data/repo/top_movies_repo.dart';
import 'package:movity/src/logic/preferences/movies/movies_preferences.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit(this.topMoviesRepo, this.mostPopularMoviesRepo)
      : super(MoviesInitial());
  final TopMoviesRepo topMoviesRepo;
  final MostPopularMoviesRepo mostPopularMoviesRepo;

  List<MovieItem>? loadedMovies = [];
  List<MovieItem>? mostPopularMovies = [];

  Future<List<MovieItem>?> getMovies() async {
// from local storage or repo ?? >>>>
// first try local storage then if null get the repo

    emit(LoadingMovies(true));
    await Future.delayed(const Duration(seconds: 2));

    loadedMovies = TopMoviesPreferences.getSavedTopMovies();
    mostPopularMovies = TopMoviesPreferences.getSavedMostPopularMovies();

    if (loadedMovies != null && mostPopularMovies != null) {
      emit(LoadingMovies(false));

      emit(LoadedTopMovis(
          topmovieItems: loadedMovies, popularMovieItems: mostPopularMovies));
    } else {
      try {
        await topMoviesRepo.creatTopMoviesRepo().then(
          (movieItemsValue) {
            loadedMovies = movieItemsValue;
          },
        );
        await mostPopularMoviesRepo
            .creatMostPopularMoviesRepo()
            .then((movieItemsValue) {
          mostPopularMovies = movieItemsValue;
        });
        emit(LoadingMovies(false));
        emit(LoadedTopMovis(
            topmovieItems: loadedMovies, popularMovieItems: mostPopularMovies));
      } catch (e) {
        emit(LoadingMovies(false));
      }
    }
    return loadedMovies;
  }
}
