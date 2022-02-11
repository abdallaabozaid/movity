import 'package:dio/dio.dart';
import 'package:movity/config/const.dart';

class TopMoviesApi {
  late Dio dio;
  TopMoviesApi() {
    BaseOptions options = BaseOptions(
      baseUrl: topMoviesBaseUrl,
      connectTimeout: 20000,
      receiveTimeout: 20000,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  Future<Map<String, dynamic>?> getTopMoviesJson() async {
    try {
      final Response response = await dio.get('');
      // print(response.data);

      return response.data;
    } catch (e) {
      print(" API error in getTopMoviesJson  : ${e.toString()}");
      return null;
    }
  }
}
