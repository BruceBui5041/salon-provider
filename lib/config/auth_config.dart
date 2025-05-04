import 'package:salon_provider/config/storage_config.dart';
import 'package:salon_provider/model/response/user_response.dart';
import 'dart:convert';

class AuthConfig {
  static Future<void> setUserId(String userId) async {
    await StorageConfig.write(StorageConfig.keyUserId, userId);
  }

  static Future<String?> getUserId() async {
    return StorageConfig.read(StorageConfig.keyUserId);
  }

  static Future<void> setUser(UserResponse user) async {
    await StorageConfig.write(StorageConfig.keyUser, jsonEncode(user.toJson()));
  }

  static Future<UserResponse?> getUser() async {
    final userJson = StorageConfig.read(StorageConfig.keyUser);
    if (userJson == null) return null;
    return UserResponse.fromJson(jsonDecode(userJson));
  }
}
