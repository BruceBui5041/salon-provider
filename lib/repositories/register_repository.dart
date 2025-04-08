import 'package:salon_provider/config/repository_config.dart';

class RegisterRepository extends RepositoryConfig {
  Future<dynamic> registerUser(
    Map<String, dynamic> requestBody,
  ) async {
    return await api.registerUser(requestBody);
  }

  Future<dynamic> verifyOtp(
    Map<String, dynamic> requestBody,
  ) async {
    return await api.verifyOtp(requestBody);
  }
}
