import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:salon_provider/common/Utils.dart';
import 'package:salon_provider/config.dart';
import 'package:salon_provider/config/storage_config.dart';
import 'package:salon_provider/network/api_config.dart';

class AuthTokenInterceptor extends Interceptor {
  static const skipHeader = 'skipHeader';
  Dio api;

  AuthTokenInterceptor(this.api);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    log("================================================================================");
    log(options.method);
    log(options.uri.toString());
    log("QueryParameters: ${options.queryParameters}");
    log("Body: ${options.data}");
    log("Headers: ${options.headers}");
    // options.headers['access_token'] = accessToken;
    // options.headers['cookie'] = accessToken;
    // options.headers['Content-Type'] = 'application/json';
    log(options.headers.toString());
    log("================================================================================");
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    List<String>? setCookie = response.headers['set-cookie'];

    if (setCookie != null) {
      await StorageConfig.saveList(setCookie);
      List<Cookie> cookies = setCookie
          .map((cookieStr) => Cookie.fromSetCookieValue(cookieStr))
          .toList();
      final config = ApiConfig();

      config.setCookies(response.requestOptions.uri, cookies);
    }

    // print("Url opi: ${response.requestOptions.uri}");
    Utils.debug("Response: ${response.data}");
    log("================================================================================");
    super.onResponse(response, handler);
  }

  @override
  onError(DioException err, ErrorInterceptorHandler handler) async {
    log("================================================================================");
    Utils.error(err);
    log("================================================================================");
    return super.onError(err, handler);
  }
}
