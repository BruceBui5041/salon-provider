import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:salon_provider/common/Utils.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/network/api_config.dart';

typedef FromJson<T> = T Function(dynamic json);

class CommonApi {
  Dio dio = getIt.get();

  Future<dynamic> search<T>(Map<String, dynamic> requestBody) async {
    try {
      final response = await dio.post("/search", data: requestBody);

      if (response.statusCode == 200) {
        // var data = response.data["data"];
        // log(data.toString());

        // Check if T is a List type by using a Type check
        bool isList = T.toString().startsWith('List<');

        if (!isList && response.data["data"].isNotEmpty) {
          return response.data["data"][0];
        }
        return response.data["data"];
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      Utils.warning(e.toString());
      throw Exception(e.toString());
    }
  }
}
