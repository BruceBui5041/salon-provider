import 'package:dio/dio.dart';

class ConfigError {
  static void onError(DioException err) {
    print('error');
    print(err.response?.statusCode);
    print(err.response);
    final response = err.response?.data;
    print(response);

    if (err.response?.statusCode == 401) {
    } else if (err.response?.statusCode == 403) {
    } else {}
  }
}
