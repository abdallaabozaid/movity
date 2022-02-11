import 'package:movity/src/data/api/movies/specific_movie_api.dart';
import 'package:movity/src/data/model/moveis/movie_model.dart';

class MovieRepo {
  final MovieApi movieApi;
  // final TopMoviesPreferences _topoviesPreferences = TopMoviesPreferences();

  MovieRepo(this.movieApi);

  Future<Movie> creatMovieRepo(String movieId) async {
    try {
      final movieJson = await movieApi.getMovieJson(movieId);

      final movieRepo = Movie.fromJson(movieJson);
// MoviePreferences.saveLocalTopMovies(movieJson, movieRepo);
      return movieRepo;
    } catch (e) {
      throw e;
    }
  }
}
