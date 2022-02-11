import 'package:flutter/material.dart';
import 'package:movity/src/data/model/moveis/movies_model.dart';
import 'package:movity/src/presentaion/screens/04_home_screen/widgets/movie_card.dart';

class MoviesBuilder extends StatelessWidget {
  const MoviesBuilder({Key? key, required this.loadedMovies}) : super(key: key);
  final List<MovieItem> loadedMovies;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      // padding: const EdgeInsets.all(12),
      itemCount: loadedMovies.length,
      itemBuilder: (BuildContext context, int index) {
        return MovieCard(movie: loadedMovies[index]);
      },
    );
  }
}
