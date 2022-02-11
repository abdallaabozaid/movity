import 'package:flutter/material.dart';
import 'package:movity/config/colors.dart';
import 'package:movity/src/data/model/moveis/movie_model.dart';
import 'package:movity/src/presentaion/screens/08_to_watch/widgets/to_watch_card_content.dart';
import 'package:movity/src/presentaion/screens/08_to_watch/widgets/watched_card_content.dart';

class WatchedItem extends StatelessWidget {
  const WatchedItem({Key? key, required this.movie}) : super(key: key);
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Card(
        color: AppColors.appGrey,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: Container(
            padding: const EdgeInsets.all(6),
            width: double.infinity,
            height: 140,
            child: WatchedCardContent(movie: movie)),
      ),
    );
  }
}
