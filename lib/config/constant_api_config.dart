import 'package:salon_provider/config/config_env.dart';

class ConstantApiConfig {
  // Thể hiện duy nhất của lớp
  static final ConstantApiConfig _instance = ConstantApiConfig._internal();

  // Biến lưu trữ URL
  String _url = "";

  // Factory constructor trả về thể hiện duy nhất
  factory ConstantApiConfig() {
    return _instance;
  }

  // Constructor riêng, không thể truy cập từ bên ngoài
  ConstantApiConfig._internal();

  // Phương thức khởi tạo cấu hình
  void init(String env) {
    final configEnv = ConfigEnv(environment: env);

    _url = configEnv.getApiUrl();
    print(env);
  }

  // Getter để truy cập URL
  String get getUrl => _url;
}
