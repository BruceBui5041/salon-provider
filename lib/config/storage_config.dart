import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageConfig {
  static const keyAccessToken = 'access_token';
  static const keyCookies = 'cookies';

  static var storage = FlutterSecureStorage();
  static Future<void> saveAccessToken(String token) async {
    await storage.write(key: keyAccessToken, value: token);
  }

  static Future<String?> getAccessToken() async {
    return await storage.read(key: keyAccessToken);
  }

  static Future<void> saveCookies(List<Cookie> cookies) async {
    await storage.write(key: keyCookies, value: "access_token=$cookies");
  }

  static Future<String?> getCookies() async {
    return await storage.read(key: keyCookies);
  }

  /// Lưu List<String> vào Secure Storage
  static Future<void> saveList(List<String> data) async {
    String jsonString = jsonEncode(data); // Chuyển List thành chuỗi JSON
    await storage.write(key: keyCookies, value: jsonString);
  }

  /// Đọc List<String> từ Secure Storage
  static Future<List<String>> readList() async {
    String? jsonString = await storage.read(key: keyCookies);
    if (jsonString != null) {
      List<dynamic> jsonList =
          jsonDecode(jsonString); // Giải mã chuỗi JSON thành List
      return List<String>.from(jsonList); // Chuyển về List<String>
    }
    return []; // Trả về danh sách rỗng nếu không có dữ liệu
  }
}

FlutterSecureStorage storageConfig = FlutterSecureStorage();

class StorageSecureConfig {
  static const userId = 'user_id';

  // write
  static Future<void> write(String key, String value) async {
    await storageConfig.write(key: key, value: value);
  }

  //read
  static Future<String?> read(String key) async {
    return await storageConfig.read(key: key);
  }

  //clear
  static Future<void> delete(String key) async {
    await storageConfig.delete(key: key);
  }

  //clear all
  static Future<void> deleteAll() async {
    await storageConfig.deleteAll();
  }
}
