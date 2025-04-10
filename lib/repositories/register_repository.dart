import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/config/repository_config.dart';
import 'package:salon_provider/network/api.dart';

class RegisterRepository extends RepositoryConfig {
  Future<dynamic> registerUser(
    Map<String, dynamic> requestBody,
  ) async {
    return await getIt.get<AuthApiClient>().registerUser(requestBody);
  }

  Future<dynamic> verifyOtp(
    Map<String, dynamic> requestBody,
  ) async {
    return await getIt.get<OtpApiClient>().verifyOtp(requestBody);
  }
}
