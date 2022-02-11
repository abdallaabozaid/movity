import 'package:dio/dio.dart';
import 'package:movity/config/const.dart';

class MostPopularMoviesApi {
  late Dio dio;
  MostPopularMoviesApi() {
    BaseOptions options = BaseOptions(
      baseUrl: mostPopularMoviesBaseUrl,
      connectTimeout: 20000,
      receiveTimeout: 20000,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  Future<Map<String, dynamic>?> getMostPopularMoviesJson() async {
    try {
      final Response response = await dio.get('');

      return response.data;
    } catch (e) {
      print(" API error  getMostPopularMoviesJson : ${e.toString()}");
      return null;
    }
  }
}
