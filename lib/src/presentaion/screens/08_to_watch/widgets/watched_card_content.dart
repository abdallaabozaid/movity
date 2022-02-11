import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movity/config/const.dart';
import 'package:movity/src/data/model/moveis/movie_model.dart';
import 'package:movity/src/presentaion/common_widgets/loading_circle.dart';

class WatchedCardContent extends StatelessWidget {
  const WatchedCardContent({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisSize: ,
      children: [
        _movieImage(context),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "Duration : ${movie.runtimeMins} mins",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Imdb : ${movie.imDbRating} / 10",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Released : ${movie.releaseDate}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ],
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
          width: 120,
          height: 120,
          fit: BoxFit.cover,
          imageUrl: movie.image,
          placeholder: (context, url) => const LoadingCircle(),
          errorWidget: (context, url, error) => const Text('faild Image'),
        ),
      ),
    );
  }
}
