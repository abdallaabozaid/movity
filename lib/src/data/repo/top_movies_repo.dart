import 'package:movity/src/data/api/movies/top_250_movies_api.dart';
import 'package:movity/src/data/model/moveis/movies_model.dart';
import 'package:movity/src/logic/preferences/movies/movies_preferences.dart';

class TopMoviesRepo {
  final TopMoviesApi topMoviesApi;
  // final TopMoviesPreferences _topoviesPreferences = TopMoviesPreferences();

  TopMoviesRepo(this.topMoviesApi);

  Future<List<MovieItem>?> creatTopMoviesRepo() async {
    final topMoviesJson = await topMoviesApi.getTopMoviesJson();
    if (topMoviesJson == null) {
      return null;
    } else {
      TopMoviesPreferences.saveLocalTopMovies(topMoviesJson);
      final topMoviesRepo = Movies.fromJson(topMoviesJson);
      return topMoviesRepo.items;
    }
  }
}
