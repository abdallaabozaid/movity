import 'package:flutter/material.dart';
import 'package:movity/config/colors.dart';
import 'package:movity/src/data/model/moveis/movie_model.dart';
import 'package:movity/src/presentaion/common_widgets/text_wraper.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({Key? key, required this.movie}) : super(key: key);
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              detailUnit(Icons.star, movie.imDbRating, Colors.yellow),
              detailUnit(
                  Icons.timer, "${movie.runtimeMins} mins", Colors.blueGrey),
            ],
          ),
          // Center(
          //   child: detailUnit(Icons.panorama_fish_eye_outlined,
          //       "${movie.imDbRatingVotes} votes", Colors.blueGrey),
          // ),

          const SizedBox(
            height: 20,
          ),
          const Text(
            'Story Line',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),

          TextWrapper(text: movie.plot),
        ],
      ),
    );
  }

  Widget detailUnit(
    IconData detailicon,
    String detailText,
    Color iconColor,
  ) {
    return SizedBox(
      // width: 90,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            detailicon,
            color: iconColor,
          ),
          Text(
            detailText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
