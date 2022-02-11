import 'package:flutter/material.dart';
import 'package:movity/src/logic/auth/cubit/auth_cubit.dart';
import 'package:movity/src/presentaion/screens/08_to_watch/to_watch_screen.dart';
import 'package:movity/src/presentaion/screens/08_to_watch/watched_screen.dart';

class MainToWatchScreen extends StatelessWidget {
  const MainToWatchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = AuthCubit.userModel!;
    return PageView(
      scrollDirection: Axis.horizontal,
      children: [
        ToWatchScreen(
          movies: user.toWatchMovies,
        ),
        WatchedScreen(
          movies: user.watchedMovies,
        )
      ],
    );
  }
}
