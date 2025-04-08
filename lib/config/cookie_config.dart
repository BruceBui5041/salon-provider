import 'package:cookie_jar/cookie_jar.dart';
import 'package:salon_provider/common/Utils.dart';
import 'package:salon_provider/config/storage_config.dart';
import 'package:salon_provider/network/api_config.dart';

class CookieConfig {
  static Future<void> setCookieToApi(Uri uri) async {
    List<String> cookiesList = await StorageConfig.readList();
    if (cookiesList.isEmpty) {
      Utils.debug("COOKIES with Access Token: $cookiesList");
    }
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
