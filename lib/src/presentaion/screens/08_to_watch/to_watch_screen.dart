import 'package:flutter/material.dart';
import 'package:movity/config/colors.dart';
import 'package:movity/src/data/model/moveis/movie_model.dart';
import 'package:movity/src/presentaion/screens/08_to_watch/widgets/to_watch_builder.dart';
import 'package:movity/src/presentaion/screens/08_to_watch/widgets/to_watch_scaffold_appbar.dart';

class ToWatchScreen extends StatelessWidget {
  const ToWatchScreen({Key? key, required this.movies}) : super(key: key);
  final List<Movie> movies;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: const ToWatchScaffoldAppBar(titleText: 'To Watch'),
        preferredSize: Size(MediaQuery.of(context).size.width, 90),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              ToWatchMoviesBuilder(movieList: movies),
            ],
          ),
          _pageSwipper(),
        ],
      ),
    );
  }

  Widget _pageSwipper() {
    return Positioned(
      right: 0,
      bottom: 100,
      child: Container(
        alignment: Alignment.centerLeft,
        width: 80,
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.appGrey,
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(40),
          ),
        ),
        child: IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          padding: const EdgeInsets.only(left: 12),
          icon: const Icon(
            Icons.arrow_back,
            size: 40,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
