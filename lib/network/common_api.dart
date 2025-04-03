import 'package:dio/dio.dart';
import 'package:salon_provider/common/Utils.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/network/api_config.dart';

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
      Utils.warning(e.toString());
      throw Exception(e.toString());
    }
  }
}
