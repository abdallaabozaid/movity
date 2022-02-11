import 'package:flutter/material.dart';
import 'package:movity/config/colors.dart';
import 'package:movity/src/data/model/moveis/movie_model.dart';
import 'package:movity/src/presentaion/screens/06_profile_screen/widgets/fav_movie_card.dart';

class FavoriteMoviesBuilder extends StatelessWidget {
  const FavoriteMoviesBuilder({Key? key, required this.favoriteMovies})
      : super(key: key);
  final List<Movie> favoriteMovies;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Favorite Movies',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        favoriteMovies.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(50.0),
                child: Text(
                  'No movies yet',
                  style: TextStyle(color: AppColors.goldenColor),
                ),
              )
            : SizedBox(
                height: 240,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  // padding: const EdgeInsets.all(12),
                  itemCount: favoriteMovies.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FavoriteMovieCard(movie: favoriteMovies[index]);
                  },
                ),
              ),
      ],
    );
  }
}
