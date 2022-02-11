import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movity/config/colors.dart';
import 'package:movity/src/data/model/moveis/movie_model.dart';
import 'package:movity/src/logic/auth/cubit/auth_cubit.dart';
import 'package:movity/src/logic/movie/cubit/movie_cubit.dart';
import 'package:movity/src/presentaion/common_widgets/loading_circle.dart';
import 'package:movity/src/presentaion/screens/00_common_widgets/alert_dialog.dart';
import 'package:movity/src/presentaion/screens/05_movie_screen/widgets/cast_details.dart';
import 'package:movity/src/presentaion/screens/05_movie_screen/widgets/custom_app_bar.dart';
import 'package:movity/src/presentaion/screens/05_movie_screen/widgets/movie_details.dart';
import 'package:movity/src/presentaion/screens/05_movie_screen/widgets/similar_movies_builder.dart';

// ignore: must_be_immutable
class MovieScreen extends StatelessWidget {
  MovieScreen({Key? key}) : super(key: key);
  bool _isLoading = true;
  Movie? movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MovieCubit, MovieState>(
        listener: (context, state) {
          if (state is LoadingMovie) {
            _isLoading = state.isLoading;
          } else if (state is LoadedMovie) {
            movie = state.movie;
          } else if (state is LoadingMovieError) {
            const AwareAlertDialog(
                    alertContentText: 'Error in loading the movie ..',
                    title: 'Error in loading the movie ..')
                .show(context, isDissmissible: false);
          }
        },
        builder: (context, state) {
          return _isLoading
              ? const Center(
                  child: LoadingCircle(),
                )
              : Stack(
                  children: [
                    CustomScrollView(
                      slivers: [
                        CustomSliverAppBar(
                          movieImg: movie!.image,
                          title: movie!.title,
                        ),
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MovieDetails(
                                    movie: movie!,
                                  ),
                                  _writerText(),
                                  _directorsText(),
                                  CastDetails(actorList: movie!.actorList),
                                  _releaseDateText(),
                                  _awardsText(),
                                  _addToFavoriteMovies(context),
                                  _similarMovies(),
                                  _buildAuthBlocListener(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    _isLoading ? Container() : _addToList(context)
                  ],
                );
        },
      ),
    );
  }

  Widget _buildAuthBlocListener() {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AlreadyInTheToWatchList) {
          const AwareAlertDialog(
                  alertContentText: 'Already in the to watch list',
                  title: 'Movie in the watch list ')
              .show(context, isDissmissible: true);

          //
        } else if (state is AlreadyInTheWatchedList) {
          //
          const AwareAlertDialog(
                  alertContentText: 'You have already watched this movie',
                  title: 'Movie watched before ')
              .show(context, isDissmissible: true);
        } else if (state is ToWatchedAdded) {
          _showSnackBar(context, 'Added to To Watch list');
        }
      },
      child: Container(),
    );
  }

  Widget _addToList(BuildContext context) {
    return Positioned(
      right: 0,
      bottom: 100,
      child: Container(
        alignment: Alignment.centerLeft,
        width: 80,
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.goldenColor,
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(40),
          ),
        ),
        child: IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          padding: const EdgeInsets.only(left: 12),
          icon: const Icon(
            Icons.add_circle_outline,
            size: 40,
            color: Colors.white,
          ),
          onPressed: () {
            //// TODO:  add to list not working im=n top of page but work down
            print('tapped');
            final auth = BlocProvider.of<AuthCubit>(context);
            auth.addToWatch(movie!);
          },
        ),
      ),
    );
  }

  Column _similarMovies() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 12, left: 12),
          child: const Text(
            'Similar Movies',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        SizedBox(
          height: 300,
          child: SimilarMoviesBuilder(
            similars: movie!.similars,
          ),
        ),
      ],
    );
  }

  Padding _awardsText() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            movie!.awards.isEmpty ? '' : "Awards",
            style: const TextStyle(
              fontSize: 20,
              fontFamily: 'Crete Round',
              color: Colors.white,
            ),
          ),
          Text(
            movie!.awards,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Crete Round',
              color: AppColors.goldenColor,
            ),
          ),
        ],
      ),
    );
  }

  Padding _writerText() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Writers",
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Crete Round',
              color: Colors.white,
            ),
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: movie!.writerList.length,
            itemBuilder: (BuildContext context, int index) {
              return Text(
                movie!.writerList[index].name,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Crete Round',
                  color: AppColors.goldenColor,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Padding _directorsText() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Director",
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Crete Round',
              color: Colors.white,
            ),
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: movie!.directorList.length,
            itemBuilder: (BuildContext context, int index) {
              return Text(
                movie!.directorList[index].name,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Crete Round',
                  color: AppColors.goldenColor,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Padding _releaseDateText() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Release Date",
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Crete Round',
              color: Colors.white,
            ),
          ),
          Text(
            movie!.releaseDate,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Crete Round',
              color: AppColors.goldenColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _addToFavoriteMovies(BuildContext context) {
    final AuthCubit auth = BlocProvider.of<AuthCubit>(context);
    return InkWell(
      // hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      // focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        bool _alreadyExist = false;
        if (AuthCubit.userModel!.favoriteMovies.contains(movie)) {
          _alreadyExist = true;
        } else {
          auth.editUser(addFavoriteMovie: movie!);
        }
        _showSnackBar(
          context,
          _alreadyExist
              ? "${movie!.title} Already in your favorite movies "
              : "${movie!.title} Added to your favorite movies ",
        );
        // ScaffoldMessenger.of(context).clearSnackBars();
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     duration: const Duration(seconds: 2),
        //     backgroundColor: Colors.transparent,
        //     padding: EdgeInsets.zero,
        //     content: Container(
        //       alignment: Alignment.center,
        //       height: 50,
        //       decoration: BoxDecoration(
        //         borderRadius: const BorderRadius.vertical(
        //           top: Radius.circular(20),
        //         ),
        //         color: AppColors.goldenColor,
        //       ),
        //       child: Text(
        //         _alreadyExist
        //             ? "${movie!.title} Already in your favorite movies "
        //             : "${movie!.title} Added to your favorite movies ",
        //         style: TextStyle(
        //           color: _alreadyExist ? Colors.red : Colors.white,
        //         ),
        //         textAlign: TextAlign.center,
        //       ),
        //     ),
        //   ),
        // );
      },
      child: Container(
        alignment: Alignment.center,
        width: 80,
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.goldenColor,
          borderRadius: const BorderRadius.horizontal(
            right: Radius.circular(40),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Add to',
              ),
              Text(
                'Fav Movies',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String contentText) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.zero,
        content: Container(
          alignment: Alignment.center,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            color: AppColors.goldenColor,
          ),
          child: Text(
            contentText,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
