import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cookie_jar/cookie_jar.dart';

class StorageConfig {
  // Keys
  static const keyAccessToken = 'access_token';
  static const keyCookies = 'cookies';
  static const keyUserId = 'user_id';
  static const keyUser = 'user';

  // Private instance
  static SharedPreferences? _prefs;

  // Initialization
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Access Token Methods
  static Future<void> saveAccessToken(String token) async {
    await _ensureInitialized();
    await _prefs!.setString(keyAccessToken, token);
  }

  static String? getAccessToken() {
    _ensureInitialized();
    return _prefs!.getString(keyAccessToken);
  }

  // Cookie Methods
  static Future<void> saveCookies(List<Cookie> cookies) async {
    await _ensureInitialized();
    await _prefs!.setString(keyCookies, "access_token=$cookies");
  }

  static String? getCookies() {
    _ensureInitialized();
    return _prefs!.getString(keyCookies);
  }

  // List Storage Methods
  static Future<void> saveList(List<String> data) async {
    await _ensureInitialized();
    String jsonString = jsonEncode(data);
    await _prefs!.setString(keyCookies, jsonString);
  }

  static List<String> readList() {
    _ensureInitialized();
    String? jsonString = _prefs!.getString(keyCookies);
    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      return List<String>.from(jsonList);
    }
    return [];
  }

  // Generic Storage Methods
  static Future<void> write(String key, String value) async {
    await _ensureInitialized();
    await _prefs!.setString(key, value);
  }

  static String? read(String key) {
    _ensureInitialized();
    return _prefs!.getString(key);
  }

  static Future<void> delete(String key) async {
    await _ensureInitialized();
    await _prefs!.remove(key);
  }

  static Future<void> deleteAll() async {
    await _ensureInitialized();
    await _prefs!.clear();
  }

  // Private helper method to ensure initialization
  static Future<void> _ensureInitialized() async {
    if (_prefs == null) {
      await init();
    }
  }
}
