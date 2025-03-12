import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:fixit_provider/config.dart';
import 'package:fixit_provider/config/storage_config.dart';
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
    print("Headers: ${options.headers}");
    // options.headers['access_token'] = accessToken;
    // options.headers['cookie'] = accessToken;
    // options.headers['Content-Type'] = 'application/json';
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
      StorageConfig.saveList(setCookie);
      List<Cookie> cookies = setCookie
          .map((cookieStr) => Cookie.fromSetCookieValue(cookieStr))
          .toList();
      final config = ApiConfig();

      config.setCookies(response.requestOptions.uri, cookies);
    }

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
