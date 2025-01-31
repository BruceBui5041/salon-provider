import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fixit_provider/network/api_config.dart';

class AuthTokenInterceptor extends Interceptor {
  static const skipHeader = 'skipHeader';

  Dio api;

  AuthTokenInterceptor(this.api);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    log("================================================================================");
    print(options.method);
    print(options.uri.toString());
    print(options.data);
    print("QueryParameters: ${options.queryParameters}");
    print(options.headers);

    try {
      log("data: ${json.encode(options.data)}");
    } catch (e) {}
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    List<String>? setCookie = response.headers['set-cookie'];
    if (setCookie != null) {
      List<Cookie> cookies = setCookie
          .map((cookieStr) => Cookie.fromSetCookieValue(cookieStr))
          .toList();
      final api = ApiConfig();

      api.setCookies(response.requestOptions.uri, cookies);
    }

    // TODO: implement onResponse

    // print("Url opi: ${response.requestOptions.uri}");
    print("Response: ${response.data}");
    log("================================================================================");
    super.onResponse(response, handler);
  }

  @override
  onError(DioException err, ErrorInterceptorHandler handler) async {
    print('error');

    return super.onError(err, handler);
  }
}
