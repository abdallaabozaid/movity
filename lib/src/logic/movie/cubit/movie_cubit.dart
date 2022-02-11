import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:movity/src/data/model/moveis/movie_model.dart';
import 'package:movity/src/data/repo/specific_movie_repo.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit(this.movieRepo) : super(MovieInitial());

  final MovieRepo movieRepo;

  Movie? loadedMovie;

  Future<Movie?> getMovie(String movieId) async {
    emit(LoadingMovie(true));
    await Future.delayed(const Duration(seconds: 2));
    print(movieId.toString());

    try {
      await movieRepo.creatMovieRepo(movieId).then(
        (movieItemsValue) {
          loadedMovie = movieItemsValue;
        },
      );
      emit(LoadingMovie(false));
      emit(LoadedMovie(loadedMovie!));
    } catch (e) {
      print("errrorrrrrrorrr is >>>> ${e.toString()}");
      emit(LoadingMovieError(e.toString()));

      print('error caught in getMovieRepo ');
      throw e;
    }
    return loadedMovie;
  }
}
