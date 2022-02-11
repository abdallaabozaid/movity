import 'package:flutter/material.dart';
import 'package:movity/src/data/model/moveis/movie_model.dart';
import 'package:movity/src/presentaion/screens/05_movie_screen/widgets/similar_movie_card.dart';

class SimilarMoviesBuilder extends StatelessWidget {
  const SimilarMoviesBuilder({Key? key, required this.similars})
      : super(key: key);
  final List<Similars> similars;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      // padding: const EdgeInsets.all(12),
      itemCount: similars.length,
      itemBuilder: (BuildContext context, int index) {
        return SimilarMovieCard(similarMovie: similars[index]);
      },
    );
  }
}
