import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movity/config/colors.dart';
import 'package:movity/config/const.dart';
import 'package:movity/src/data/model/moveis/movies_model.dart';

class RecommendedMoviesWidget extends StatelessWidget {
  RecommendedMoviesWidget({Key? key, required this.recommendedMovies})
      : super(key: key);
  final List<MovieItem> recommendedMovies;
  final CarouselController _buttonCarouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      // alignment: Alignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3,
          child: CarouselSlider(
            items: recommendedMovies
                .map((selectedMovie) =>
                    _buildSelectedMovie(context, selectedMovie))
                .toList(),
            carouselController: _buttonCarouselController,
            options: CarouselOptions(
              autoPlay: true,
              disableCenter: false,
              enlargeCenterPage: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedMovie(BuildContext context, MovieItem movie) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, movieScreen, arguments: movie.id),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: CachedNetworkImage(
                  placeholderFadeInDuration: const Duration(seconds: 0),
                  imageUrl: movie.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  placeholder: (context, url) {
                    return const Image(
                      image: AssetImage(
                        'assets/images/common/loading_circle.gif',
                      ),
                      fit: BoxFit.cover,
                    );
                  },
                  errorWidget: (context, url, error) {
                    return const Image(
                      image:
                          AssetImage('assets/images/common/loading_circle.gif'),
                    );
                  },
                )),
            Positioned(
              bottom: 0,
              child: Container(
                height: 40,
                // width: 200,

                decoration: BoxDecoration(
                    color: AppColors.goldenColor.withOpacity(0.7),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    )),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      movie.title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
