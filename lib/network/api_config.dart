import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:salon_provider/config/constant_api_config.dart';
import 'package:salon_provider/network/interceptor.dart';
import 'package:salon_provider/network/ws_api.dart';
import 'package:get_it/get_it.dart';

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
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    // Initialize WebSocketApi if it's registered in GetIt
    try {
      GetIt.instance.isRegistered<WebSocketApi>();
      // WebSocketApi is already initialized through GetIt
    } catch (e) {
      // GetIt might not be initialized yet, which is fine
    }

    return dio;
  }

  // Add method to set cookies
  void setCookies(Uri uri, List<Cookie> cookies) {
    cookieJar.saveFromResponse(uri, cookies);
  }

  // Get access token from cookies
  static Future<String?> getAccessToken() async {
    try {
      final cookies =
          await cookieJar.loadForRequest(Uri.parse(ConstantApiConfig().getUrl));
      for (var cookie in cookies) {
        if (cookie.name == 'access_token') {
          return cookie.value;
        }
      }
    } catch (e) {
      // Handle error
    }
    return null;
  }

  // Helper method to connect WebSocket with current token
  static Future<void> connectWebSocket({
    required String endpoint,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      if (GetIt.instance.isRegistered<WebSocketApi>()) {
        final wsApi = GetIt.instance<WebSocketApi>();
        final token = await getAccessToken();
        await wsApi.connect(
          endpoint: endpoint,
          queryParams: queryParams,
          token: token,
        );
      }
    } catch (e) {
      // Handle error
    }
  }
}
