import 'package:flutter/material.dart';
import 'package:movity/config/colors.dart';
import 'package:movity/src/data/model/moveis/movie_model.dart';
import 'package:movity/src/logic/auth/cubit/auth_cubit.dart';
import 'package:movity/src/presentaion/screens/06_profile_screen/widgets/edit_fav_movie_card.dart';

class EditFavoriteMoviesBuilder extends StatelessWidget {
  EditFavoriteMoviesBuilder({Key? key}) : super(key: key);
  final List<Movie> favoriteMovies = AuthCubit.userModel!.favoriteMovies;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(
            'Favorite Movies',
            style: TextStyle(color: AppColors.goldenColor),
          ),
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
                  itemCount: favoriteMovies.length,
                  itemBuilder: (BuildContext context, int index) {
                    return EditFavoriteMovieCard(movie: favoriteMovies[index]);
                  },
                ),
              ),
      ],
    );
  }
}
