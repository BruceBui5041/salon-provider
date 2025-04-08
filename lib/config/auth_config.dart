import 'package:salon_provider/config/storage_config.dart';

class AuthConfig {
  static Future<void> setUserId(String userId) async {
    await StorageConfig.write(StorageConfig.keyUserId, userId);
  }

  static Future<String?> getUserId() async {
    return StorageConfig.read(StorageConfig.keyUserId);
  }
}
