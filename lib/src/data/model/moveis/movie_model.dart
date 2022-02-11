class Movie {
  Movie({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.type,
    required this.year,
    required this.image,
    required this.releaseDate,
    required this.runtimeMins,
    required this.plot,
    required this.awards,
    required this.directorList,
    required this.writerList,
    required this.starList,
    required this.actorList,
    required this.genreList,
    required this.imDbRating,
    required this.imDbRatingVotes,
    required this.similars,
  });
  late String id;
  late String title;
  late String originalTitle;
  late String type;
  late String year;
  late String image;
  late String releaseDate;
  late String runtimeMins;
  late String plot;
  late String awards;
  late List<DirectorList> directorList;
  late List<WriterList> writerList;
  late List<StarList> starList;
  late List<ActorList> actorList;
  late List<GenreList> genreList;
  late String imDbRating;
  late String imDbRatingVotes;

  late List<Similars> similars;

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    originalTitle = json['originalTitle'];
    type = json['type'];
    year = json['year'];
    image = json['image'];
    releaseDate = json['releaseDate'];
    runtimeMins = json['runtimeMins'];
    plot = json['plot'];
    awards = json['awards'];
    directorList = List.from(json['directorList'])
        .map((e) => DirectorList.fromJson(e))
        .toList();
    writerList = List.from(json['writerList'])
        .map((e) => WriterList.fromJson(e))
        .toList();
    starList =
        List.from(json['starList']).map((e) => StarList.fromJson(e)).toList();
    actorList =
        List.from(json['actorList']).map((e) => ActorList.fromJson(e)).toList();
    genreList =
        List.from(json['genreList']).map((e) => GenreList.fromJson(e)).toList();
    imDbRating = json['imDbRating'];
    imDbRatingVotes = json['imDbRatingVotes'];

    similars =
        List.from(json['similars']).map((e) => Similars.fromJson(e)).toList();
  }

  // Map<String, dynamic> toJson() {
  //   final _data = <String, dynamic>{};
  //   _data['id'] = id;
  //   _data['title'] = title;
  //   _data['originalTitle'] = originalTitle;
  //   _data['type'] = type;
  //   _data['year'] = year;
  //   _data['image'] = image;
  //   _data['releaseDate'] = releaseDate;
  //   _data['runtimeMins'] = runtimeMins;
  //   _data['plot'] = plot;
  //   _data['awards'] = awards;
  //   _data['directorList'] = directorList;
  //   _data['writerList'] = writerList;
  //   _data['starList'] = starList;
  //   _data['actorList'] = actorList;
  //   _data['genreList'] = genreList;
  //   _data['imDbRating'] = imDbRating;
  //   _data['imDbRatingVotes'] = imDbRatingVotes;
  //   return _data;
  // }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['originalTitle'] = originalTitle;
    _data['type'] = type;
    _data['year'] = year;
    _data['image'] = image;
    _data['releaseDate'] = releaseDate;
    _data['runtimeMins'] = runtimeMins;
    _data['plot'] = plot;
    _data['awards'] = awards;
    _data['directorList'] = directorList.map((e) => e.toJson()).toList();
    _data['writerList'] = writerList.map((e) => e.toJson()).toList();
    _data['starList'] = starList.map((e) => e.toJson()).toList();
    _data['actorList'] = actorList.map((e) => e.toJson()).toList();
    _data['genreList'] = genreList.map((e) => e.toJson()).toList();
    _data['imDbRating'] = imDbRating;
    _data['imDbRatingVotes'] = imDbRatingVotes;
    _data['similars'] = similars.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DirectorList {
  DirectorList({
    required this.id,
    required this.name,
  });
  late final String id;
  late final String name;

  DirectorList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class WriterList {
  WriterList({
    required this.id,
    required this.name,
  });
  late final String id;
  late final String name;

  WriterList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class StarList {
  StarList({
    required this.id,
    required this.name,
  });
  late final String id;
  late final String name;

  StarList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class ActorList {
  ActorList({
    required this.id,
    required this.image,
    required this.name,
    required this.asCharacter,
  });
  late final String id;
  late final String image;
  late final String name;
  late final String asCharacter;

  ActorList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    asCharacter = json['asCharacter'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['image'] = image;
    _data['name'] = name;
    _data['asCharacter'] = asCharacter;
    return _data;
  }
}

class GenreList {
  GenreList({
    required this.key,
    required this.value,
  });
  late final String key;
  late final String value;

  GenreList.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['key'] = key;
    _data['value'] = value;
    return _data;
  }
}

class Similars {
  Similars({
    required this.id,
    required this.title,
    required this.fullTitle,
    required this.year,
    required this.image,
    required this.plot,
    required this.directors,
    required this.stars,
    required this.genres,
    required this.imDbRating,
  });
  late final String id;
  late final String title;
  late final String fullTitle;
  late final String year;
  late final String image;
  late final String plot;
  late final String directors;
  late final String stars;
  late final String genres;
  late final String imDbRating;

  Similars.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    fullTitle = json['fullTitle'];
    year = json['year'];
    image = json['image'];
    plot = json['plot'];
    directors = json['directors'];
    stars = json['stars'];
    genres = json['genres'];
    imDbRating = json['imDbRating'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['fullTitle'] = fullTitle;
    _data['year'] = year;
    _data['image'] = image;
    _data['plot'] = plot;
    _data['directors'] = directors;
    _data['stars'] = stars;
    _data['genres'] = genres;
    _data['imDbRating'] = imDbRating;
    return _data;
  }
}
