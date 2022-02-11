// class SearchedMovies {
//   // SearchedMovies(this.searchedMovies);
//   late List<SearchedMovie> searchedMovies;

//   SearchedMovies.fromJson(Map<String, dynamic> json) {
//     searchedMovies = List.from(json['results'])
//         .map((e) => SearchedMovie.fromJson(e))
//         .toList();
//   }
// }

class SearchedMovies {
  SearchedMovies({
    required this.searchType,
    required this.expression,
    required this.searchedMovies,
    required this.errorMessage,
  });
  late final String searchType;
  late final String expression;
  late final List<SearchedMovie> searchedMovies;
  late final String errorMessage;

  SearchedMovies.fromJson(Map<String, dynamic> json) {
    searchType = json['searchType'];
    expression = json['expression'];
    searchedMovies = List.from(json['results'])
        .map((e) => SearchedMovie.fromJson(e))
        .toList();
    errorMessage = json['errorMessage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['searchType'] = searchType;
    _data['expression'] = expression;
    _data['results'] = searchedMovies.map((e) => e.toJson()).toList();
    _data['errorMessage'] = errorMessage;
    return _data;
  }
}

class SearchedMovie {
  SearchedMovie({
    required this.id,
    required this.resultType,
    required this.image,
    required this.title,
    required this.description,
  });
  late final String id;
  late final String resultType;
  late final String image;
  late final String title;
  late final String description;

  SearchedMovie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resultType = json['resultType'];
    image = json['image'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['resultType'] = resultType;
    _data['image'] = image;
    _data['title'] = title;
    _data['description'] = description;
    return _data;
  }
}
