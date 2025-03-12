import 'package:fixit_provider/config/storage_config.dart';

class AuthConfig {
  static Future<void> setUserId(String userId) async {
    await StorageSecureConfig.write(StorageSecureConfig.userId, userId);
  }

  static Future<String?> getUserId() async {
    return await StorageSecureConfig.read(StorageSecureConfig.userId);
  }
}
