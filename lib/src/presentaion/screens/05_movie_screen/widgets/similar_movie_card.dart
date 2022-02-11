import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movity/config/colors.dart';
import 'package:movity/config/const.dart';
import 'package:movity/src/data/model/moveis/movie_model.dart';

// ignore: must_be_immutable
class SimilarMovieCard extends StatelessWidget {
  SimilarMovieCard({Key? key, required this.similarMovie}) : super(key: key);
  Similars similarMovie;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () => Navigator.pushReplacementNamed(context, movieScreen,
            arguments: similarMovie.id),
        child: Container(
          width: 160,
          height: 240,
          decoration: BoxDecoration(
            // image: DecorationImage(image: image),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    placeholderFadeInDuration: const Duration(seconds: 0),
                    imageUrl: similarMovie.image,
                    width: 160,
                    height: 240,
                    fit: BoxFit.cover,
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
                    similarMovie.imDbRating,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
