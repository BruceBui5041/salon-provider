import 'dart:developer';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:fixit_provider/config/storage_config.dart';
import 'package:fixit_provider/network/api_config.dart';

class CookieConfig {
  static Future<void> setCookieToApi(Uri uri) async {
    List<String> cookiesList = await StorageConfig.readList();
    // StorageConfig.saveAccessToken(
    //     cookiesList[0].replaceAll("access_token=", ""));
    // log(cookiesList[0]);
    if (cookiesList.isNotEmpty) {
      List<Cookie> cookies = cookiesList
          .map((cookieStr) => Cookie.fromSetCookieValue(cookieStr))
          .toList();
      final config = ApiConfig();

      config.setCookies(uri, cookies);
    }
  }
}
