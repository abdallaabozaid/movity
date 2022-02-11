import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movity/config/colors.dart';
import 'package:movity/config/const.dart';

import 'package:movity/src/data/model/moveis/movie_model.dart';
import 'package:movity/src/logic/auth/cubit/auth_cubit.dart';
import 'package:movity/src/presentaion/common_widgets/loading_circle.dart';

class CardContent extends StatelessWidget {
  CardContent({
    Key? key,
    required this.movie,
    required this.index,
    required this.watched,
  }) : super(key: key);

  final Movie movie;
  final int index;
  bool watched = false;

  @override
  Widget build(BuildContext context) {
    print('card rebuilt');
    return Row(
      children: [
        _movieImage(context),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "Duration : ${movie.runtimeMins} mins",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Imdb : ${movie.imDbRating} / 10",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Released : ${movie.releaseDate}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
        // const Spacer(),
        BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
          return _checkBox(context);
        }),
      ],
    );
  }

  Widget _checkBox(BuildContext context) {
    final AuthCubit auth = BlocProvider.of<AuthCubit>(context);

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        watched = auth.checkWatched(movie);
      },
      child: Container(
        width: 30,
        height: 30,
        // color: Colors.black,
        padding: const EdgeInsets.only(right: 15),
        child: Checkbox(
          activeColor: Colors.white,
          checkColor: AppColors.goldenColor,
          fillColor: MaterialStateProperty.all<Color>(Colors.black),
          splashRadius: 1,
          overlayColor: MaterialStateProperty.all<Color>(Colors.black),
          value: watched,
          onChanged: (value) {
            if (value!) {
              auth.addToWatched(movie);
            } else {
              auth.unwatched(movie, index);
            }
          },
        ),
      ),
    );
  }

  Widget _movieImage(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        Navigator.pushNamed(context, movieScreen, arguments: movie.id);
      },
      child: ClipOval(
        child: CachedNetworkImage(
            placeholderFadeInDuration: const Duration(seconds: 0),
            fadeInDuration: const Duration(seconds: 0),
            width: 120,
            height: 120,
            fit: BoxFit.cover,
            imageUrl: movie.image,
            placeholder: (context, url) => const LoadingCircle(),
            errorWidget: (context, url, error) => const Text('faild Image')),
      ),
    );
  }
}
