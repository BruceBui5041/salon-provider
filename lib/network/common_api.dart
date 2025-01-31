import 'package:dio/dio.dart';
import 'package:fixit_provider/network/api_config.dart';

typedef FromJson<T> = T Function(Map<String, dynamic> json);

class CommonApi {
  Dio dio = ApiConfig.createDio();

  Future<T> search<T>(FromJson<T> fromJson, T requestBody) async {
    final response = await dio.post("/search", data: requestBody);
    if (response.statusCode == 200) {
      return fromJson(response.data);
    } else {
      throw Exception("Failed to load data");
    }
  }
}
