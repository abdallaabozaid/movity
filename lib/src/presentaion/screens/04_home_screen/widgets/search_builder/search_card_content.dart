import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movity/src/data/model/moveis/searched_movies_model.dart';
import 'package:movity/src/presentaion/common_widgets/loading_circle.dart';

class ResultCardContent extends StatelessWidget {
  const ResultCardContent({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final SearchedMovie movie;

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisSize: ,
      children: [
        _movieImage(),
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
                  "Released : ${movie.description}",
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

  ClipOval _movieImage() {
    return ClipOval(
      child: CachedNetworkImage(
          placeholderFadeInDuration: const Duration(seconds: 0),
          width: 120,
          height: 120,
          fit: BoxFit.cover,
          imageUrl: movie.image,
          placeholder: (context, url) => const LoadingCircle(),
          errorWidget: (context, url, error) => const Text('faild Image')),
    );
  }
}
