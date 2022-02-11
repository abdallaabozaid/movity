import 'package:flutter/material.dart';
import 'package:movity/config/colors.dart';
import 'package:movity/src/data/model/moveis/movie_model.dart';
import 'package:movity/src/presentaion/screens/08_to_watch/widgets/watched_builder.dart';
import 'package:movity/src/presentaion/screens/08_to_watch/widgets/watched_scaffold_app_bar.dart';

class WatchedScreen extends StatelessWidget {
  const WatchedScreen({Key? key, required this.movies}) : super(key: key);
  final List<Movie> movies;
  @override
  Widget build(BuildContext context) {
    // movies = AuthCubit.userModel!.toWatchMovies;
    return Scaffold(
      appBar: PreferredSize(
        child: const WatchedScaffoldAppBar(titleText: 'Watched'),
        preferredSize: Size(MediaQuery.of(context).size.width, 90),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              WatchedMoviesBuilder(movieList: movies),
            ],
          ),
          _pageSwipper()
        ],
      ),
    );
  }

  Widget _pageSwipper() {
    return Positioned(
      left: 0,
      bottom: 100,
      child: Container(
        alignment: Alignment.centerRight,
        width: 80,
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.goldenColor,
          borderRadius: const BorderRadius.horizontal(
            right: Radius.circular(40),
          ),
        ),
        child: IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          padding: const EdgeInsets.only(right: 12),
          icon: const Icon(
            Icons.arrow_forward,
            size: 40,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
