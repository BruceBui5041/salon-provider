import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageConfig {
  static const keyAccessToken = 'access_token';

  static var storage = FlutterSecureStorage();
  static Future<void> saveAccessToken(String token) async {
    await storage.write(key: keyAccessToken, value: token);
  }

  static Future<String?> getAccessToken() async {
    return await storage.read(key: keyAccessToken);
  }
}
