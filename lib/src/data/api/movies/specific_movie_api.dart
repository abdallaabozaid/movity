import 'package:dio/dio.dart';
import 'package:movity/config/const.dart';

class MovieApi {
  late Dio dio;
  MovieApi() {
    BaseOptions options = BaseOptions(
      baseUrl: specificMovieBaseUrl,
      connectTimeout: 20000,
      receiveTimeout: 20000,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  Future<Map<String, dynamic>> getMovieJson(String movieId) async {
    try {
      final Response response = await dio.get(movieId);
      // print(response.data);
      return response.data;
    } catch (e) {
      print("getMovieJson API error : ${e.toString()}");
      rethrow;
    }
  }
}
