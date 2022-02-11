import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movity/config/colors.dart';
import 'package:movity/src/data/model/moveis/movie_model.dart';
import 'package:movity/src/logic/auth/cubit/auth_cubit.dart';
import 'package:movity/src/presentaion/screens/08_to_watch/widgets/to_watch_item.dart';
import 'package:movity/src/presentaion/screens/08_to_watch/widgets/watched_item.dart';

class WatchedMoviesBuilder extends StatelessWidget {
  const WatchedMoviesBuilder({Key? key, required this.movieList})
      : super(key: key);
  final List<Movie> movieList;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return movieList.isEmpty
            ? _emptyText()
            : Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: movieList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return WatchedItem(
                      movie: movieList[index],
                    );
                  },
                ),
              );
      },
    );
  }

  Widget _emptyText() {
    return Center(
      child: Text(
        'There is movies to watch',
        style: TextStyle(color: AppColors.goldenColor, fontSize: 25),
      ),
    );
  }
}
