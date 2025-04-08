// config_env.dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ConfigEnv {
  final String environment;

  ConfigEnv({required this.environment}) {
    _loadConfig();
  }

  // Các biến môi trường chung
  late final String apiUrl;

  void _loadConfig() {
    String prefix = "";

    switch (environment.toUpperCase()) {
      case "DEV":
        prefix = "DEV";
        break;
      case "PROD":
        prefix = "PROD";
        break;

      default:
        throw Exception("Môi trường '${environment}' không hợp lệ.");
    }

    // Lấy các biến môi trường dựa trên prefix
    apiUrl = dotenv.env['${prefix}_API'] ?? "";
  }

  Map<String, String> getConfig() {
    return {
      "API": apiUrl,
    };
  }

  String getApiUrl() {
    return apiUrl ?? '';
  }
}
