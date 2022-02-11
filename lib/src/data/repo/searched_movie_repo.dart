import 'package:movity/src/data/api/movies/searched_movies_api.dart';
import 'package:movity/src/data/model/moveis/searched_movies_model.dart';

class SearchedMoviesRepo {
  final SearchedMoviesApi searchedMoviesApi;
  // final SearchedMoviesPreferences _SearchedoviesPreferences = SearchedMoviesPreferences();

  SearchedMoviesRepo(this.searchedMoviesApi);

  Future<List<SearchedMovie>?> creatSearchedMoviesRepo(
      String searchWord) async {
    final searchedMoviesJson =
        await searchedMoviesApi.getSearchedMoviesJson(searchWord);
    if (searchedMoviesJson == null) {
      return null;
    } else {
      // SearchedMoviesPreferences.saveLocalSearchedMovies(SearchedMoviesJson);
      final searchedMoviesRepo = SearchedMovies.fromJson(searchedMoviesJson);
      return searchedMoviesRepo.searchedMovies;
    }
  }
}
