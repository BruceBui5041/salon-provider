import 'package:dio/dio.dart';

class ConfigError {
  static void onError(DioException err) {
    final response = err.response?.data;

    if (err.response?.statusCode == 401) {
    } else if (err.response?.statusCode == 403) {
    } else {}
  }
}
