class Movies {
  Movies({
    required this.items,
  });
  late final List<MovieItem> items;

  Movies.fromJson(Map<String, dynamic> json) {
    items = List.from(json['items']).map((e) => MovieItem.fromJson(e)).toList();
  }
}

class MovieItem {
  MovieItem({
    required this.id,
    required this.rank,
    required this.title,
    required this.fullTitle,
    required this.year,
    required this.image,
    required this.crew,
    required this.imDbRating,
    required this.imDbRatingCount,
  });
  late final String id;
  late final String rank;
  late final String title;
  late final String fullTitle;
  late final String year;
  late final String image;
  late final String crew;
  late final String imDbRating;
  late final String imDbRatingCount;

  MovieItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rank = json['rank'];
    title = json['title'];
    fullTitle = json['fullTitle'];
    year = json['year'];
    image = json['image'];
    crew = json['crew'];
    imDbRating = json['imDbRating'];
    imDbRatingCount = json['imDbRatingCount'];
  }
}
