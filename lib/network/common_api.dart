import 'package:dio/dio.dart';
import 'package:fixit_provider/config/injection_config.dart';
import 'package:fixit_provider/network/api_config.dart';

typedef FromJson<T> = T Function(Map<String, dynamic> json);

class CommonApi {
  Dio dio = getIt.get();

  Future<T> search<T>(
      FromJson<T> fromJson, Map<String, dynamic> requestBody) async {
    try {
      final response = await dio.post("/search", data: requestBody);
      if (response.statusCode == 200) {
        return fromJson(response.data);
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      print(e);
      throw Exception("Failed to load data");
    }
  }
}
