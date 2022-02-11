import 'package:dio/dio.dart';
import 'package:movity/config/const.dart';

class SearchedMoviesApi {
  late Dio dio;
  SearchedMoviesApi() {
    BaseOptions options = BaseOptions(
      baseUrl: searchedMoviesBaseUrl,
      connectTimeout: 20000,
      receiveTimeout: 20000,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  // Future<Map<String, dynamic>> getSearchedMoviesJson(String searchWord) async {
  //   try {
  //     print('getSearchedMovies api called');
  //     final Response response = await dio.get(searchWord);
  //     // print(response.data);
  //     return response.data;
  //   } catch (e) {
  //     print("getSearchedMovies API error : ${e.toString()}");
  //     rethrow;
  //   }
  // }

  Future<Map<String, dynamic>?> getSearchedMoviesJson(String searchWord) async {
    try {
      final Response response = await dio.get(searchWord);
      // print(response.data);
      print('search api called');
      return response.data;
    } catch (e) {
      print(" API error  getMostPopularMoviesJson : ${e.toString()}");
      return null;
    }
  }
}
