import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movity/config/const.dart';
import 'package:movity/src/data/api/movies/most_popular_movies.dart';
import 'package:movity/src/data/api/movies/searched_movies_api.dart';
import 'package:movity/src/data/api/movies/specific_movie_api.dart';
import 'package:movity/src/data/api/movies/top_250_movies_api.dart';
import 'package:movity/src/data/repo/most_popular_movies_repo.dart';
import 'package:movity/src/data/repo/searched_movie_repo.dart';
import 'package:movity/src/data/repo/specific_movie_repo.dart';
import 'package:movity/src/data/repo/top_movies_repo.dart';
import 'package:movity/src/logic/landing/landing_screen.dart';
import 'package:movity/src/logic/movie/cubit/movie_cubit.dart';
import 'package:movity/src/logic/movies/cubit/movies_cubit.dart';
import 'package:movity/src/logic/searched_movies/bloc/searched_movies_bloc.dart';
import 'package:movity/src/presentaion/screens/01_on_boarding/on_boarding_screen.dart';
import 'package:movity/src/presentaion/screens/02_sign_up/sign_up_screen.dart';
import 'package:movity/src/presentaion/screens/03_new_user_screen/anon_new_user_screen.dart';
import 'package:movity/src/presentaion/screens/03_new_user_screen/new_user_screen.dart';
import 'package:movity/src/presentaion/screens/04_home_screen/home_screen.dart';
import 'package:movity/src/presentaion/screens/05_movie_screen/movie_screen.dart';
import 'package:movity/src/presentaion/screens/06_profile_screen/edit_profile_screen.dart';
import 'package:movity/src/presentaion/screens/06_profile_screen/profile_screen.dart';
import 'package:movity/src/presentaion/screens/07_settings_screen/settingsScreen.dart';
import 'package:movity/src/presentaion/screens/08_to_watch/main_to_watch_screen.dart';

import 'package:page_transition/page_transition.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case landingScreen:
        return MaterialPageRoute(builder: ((context) => const LandingScreen()));
      case onBoardingScreen:
        return PageTransition(
          child: const OnBoardingScreen(),
          settings: settings,
          type: PageTransitionType.fade,
        );
      case signUpScreen:
        final bool fromSignOut = settings.arguments as bool;
        return PageTransition(
          child: SignUpScreen(fromSignOut: fromSignOut),
          settings: settings,
          type: PageTransitionType.fade,
        );

      case homeScreen:
        return PageTransition(
          child: MultiBlocProvider(
            providers: [
              BlocProvider<MoviesCubit>(
                create: (_) {
                  final moviesCubit = MoviesCubit(
                    TopMoviesRepo(TopMoviesApi()),
                    MostPopularMoviesRepo(MostPopularMoviesApi()),
                  );
                  moviesCubit.getMovies();

                  return moviesCubit;
                },
              ),
              BlocProvider<SearchedMoviesBloc>(
                create: (_) {
                  final searchedMoviesBloc = SearchedMoviesBloc(
                      SearchedMoviesRepo(SearchedMoviesApi()));

                  return searchedMoviesBloc;
                },
              )
            ],
            child: const HomeScreen(),
          ),
          settings: settings,
          type: PageTransitionType.fade,
          duration: const Duration(seconds: 2),
        );

      case newUserScreen:
        return PageTransition(
          child: const NewUserScreen(),
          settings: settings,
          type: PageTransitionType.rightToLeft,
        );
      case anonNewUserScreen:
        return PageTransition(
          child: const AnonNewUserScreen(),
          settings: settings,
          type: PageTransitionType.rightToLeft,
        );

      case profileScreen:
        return PageTransition(
          child: const ProfileScreen(),
          settings: settings,
          type: PageTransitionType.leftToRightWithFade,
        );

      case settingsScreen:
        return PageTransition(
          child: const SettingsScreen(),
          settings: settings,
          type: PageTransitionType.leftToRightWithFade,
        );

      case editProfileScreen:
        final isNew = settings.arguments as bool;
        return PageTransition(
          child: EditProfileScreen(
            isNew: isNew,
          ),
          settings: settings,
          type: PageTransitionType.bottomToTop,
        );

      case mainToWatchScreen:
        return PageTransition(
          child: const MainToWatchScreen(),
          settings: settings,
          type: PageTransitionType.bottomToTop,
        );
      // case toWatchScreen:
      //   return PageTransition(
      //     child: ToWatchScreen(),
      //     settings: settings,
      //     type: PageTransitionType.bottomToTop,
      //   );

      // case watchedScreen:
      //   return PageTransition(
      //     child: const WatchedScreen(),
      //     settings: settings,
      //     type: PageTransitionType.bottomToTop,
      //   );

      case movieScreen:
        final movieId = settings.arguments as String;

        return PageTransition(
            child: BlocProvider<MovieCubit>(
              create: (_) {
                final movieCubit = MovieCubit(MovieRepo(MovieApi()));
                movieCubit.getMovie(movieId);
                return movieCubit;
              },
              child: MovieScreen(),
            ),
            settings: settings,
            type: PageTransitionType.rightToLeftWithFade,
            duration: const Duration(seconds: 1));
      default:
        Container();
        return MaterialPageRoute(builder: ((context) => Container()));
    }
  }

// disposing blocs when used in blocProvider.value
  // static void dispose() {
  //   _bloc.close();
  // }
}
