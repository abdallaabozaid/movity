import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movity/config/colors.dart';
import 'package:movity/config/const.dart';
import 'package:movity/src/data/model/moveis/movie_model.dart';
import 'package:movity/src/logic/auth/cubit/auth_cubit.dart';

// import 'package:cached_network_image/cached_network_image.dart';
// ignore: must_be_immutable
class EditFavoriteMovieCard extends StatelessWidget {
  EditFavoriteMovieCard({Key? key, required this.movie}) : super(key: key);
  Movie movie;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(movie.id),
      direction: DismissDirection.up,
      onDismissed: (direction) {
        AuthCubit.userModel!.favoriteMovies
            .removeWhere((element) => movie.id == element.id);
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: 160,
          height: 240,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    placeholderFadeInDuration: const Duration(seconds: 0),
                    imageUrl: movie.image,
                    width: 160,
                    height: 240,
                    placeholder: (context, url) => const Image(
                      image: AssetImage(
                        'assets/images/common/img_loading.gif',
                      ),
                      width: 160,
                      height: 240,
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (context, url, error) => const Image(
                      width: 160,
                      height: 240,
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/common/img_loading.gif'),
                    ),
                  )),
              Positioned(
                right: 8,
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  height: 50,
                  width: 50,
                  child: Text(
                    movie.imDbRating,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.goldenColor,
                      fontSize: 24,
                    ),
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.black87,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(26)),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.arrow_upward_sharp,
                  size: 100,
                  color: Colors.red,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
