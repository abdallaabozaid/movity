import 'package:flutter/material.dart';
import 'package:movity/config/colors.dart';
import 'package:movity/config/const.dart';
import 'package:movity/src/data/model/moveis/searched_movies_model.dart';
import 'package:movity/src/presentaion/screens/04_home_screen/widgets/search_builder/search_card_content.dart';

class ResultItem extends StatelessWidget {
  const ResultItem({Key? key, required this.movie}) : super(key: key);
  final SearchedMovie movie;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        Navigator.pushNamed(context, movieScreen, arguments: movie.id);
      },
      child: Padding(
        padding: EdgeInsets.zero,
        child: Card(
          color: AppColors.goldenColor,
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          child: Container(
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.goldenColor, width: 3),
              ),
              child: ResultCardContent(movie: movie)),
        ),
      ),
    );
  }
}
