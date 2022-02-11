import 'package:movity/src/data/api/movies/most_popular_movies.dart';
import 'package:movity/src/data/model/moveis/movies_model.dart';
import 'package:movity/src/logic/preferences/movies/movies_preferences.dart';

class MostPopularMoviesRepo {
  final MostPopularMoviesApi mostPopularMoviesApi;
  // final TopMoviesPreferences _topoviesPreferences = TopMoviesPreferences();

  MostPopularMoviesRepo(this.mostPopularMoviesApi);

  Future<List<MovieItem>?> creatMostPopularMoviesRepo() async {
    final mostPopularMoviesJson =
        await mostPopularMoviesApi.getMostPopularMoviesJson();
    if (mostPopularMoviesJson == null) {
      return null;
    } else {
      TopMoviesPreferences.saveLocalMostPopularMovies(mostPopularMoviesJson);

      final mostPopularMoviesRepo = Movies.fromJson(mostPopularMoviesJson);
      return mostPopularMoviesRepo.items;
    }
  }
}
