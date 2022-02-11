import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movity/config/colors.dart';
import 'package:movity/config/const.dart';
import 'package:movity/src/data/model/moveis/movies_model.dart';

// import 'package:cached_network_image/cached_network_image.dart';
// ignore: must_be_immutable
class MovieCard extends StatelessWidget {
  MovieCard({Key? key, required this.movie}) : super(key: key);
  MovieItem movie;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () =>
            Navigator.pushNamed(context, movieScreen, arguments: movie.id),
        child: Container(
          width: 160,
          height: 240,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
