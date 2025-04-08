import 'package:dio/dio.dart';
import 'package:salon_provider/common/Utils.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/network/api.dart';
import 'package:salon_provider/repositories/token_repository.dart';

class VerifyOtpRepository {
  var restClient = getIt.get<RestClient>();
  Future verifyOtp(Map<String, dynamic> requestBody) async {
    await restClient.verifyOtp(requestBody);
  }

  Future saveUserDevice(String token) async {
    try {
      await getIt.get<TokenRepository>().saveUserDevice(token);
    } catch (e) {
      if (e is DioException) {
        Utils.error(e);
      }
    }
  }
}
