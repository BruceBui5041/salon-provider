import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:salon_provider/config/constant_api_config.dart';
import 'package:salon_provider/config/storage_config.dart';
import 'package:salon_provider/network/interceptor.dart';

class ApiConfig {
  ApiConfig._instance();
  static final instance = ApiConfig._instance();
  factory ApiConfig() => instance;

  final dio = createDio();
  static final CookieJar cookieJar = CookieJar();

  static Dio createDio() {
    var dio = Dio(BaseOptions(
        receiveTimeout: const Duration(milliseconds: 70000), // 15 seconds
        connectTimeout: const Duration(milliseconds: 70000),
        sendTimeout: const Duration(milliseconds: 70000),
        baseUrl: ConstantApiConfig().getUrl));
    // Add interceptors, including CookieManager
    dio.interceptors.addAll([
      AuthTokenInterceptor(dio),
      CookieManager(cookieJar), // Add CookieManager here
    ]);

    // Allow self-signed certificates (if needed)
    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    return dio;
  }

  // Add method to set cookies
  void setCookies(Uri uri, List<Cookie> cookies) {
    cookieJar.saveFromResponse(uri, cookies);
  }

  // return cookie
  void getCookies(Uri uri) {
    cookieJar.loadForRequest(uri);
  }
}
