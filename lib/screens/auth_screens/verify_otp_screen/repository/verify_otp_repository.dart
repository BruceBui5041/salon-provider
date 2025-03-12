import 'package:fixit_provider/config/injection_config.dart';
import 'package:fixit_provider/network/api.dart';

class VerifyOtpRepository {
  var restClient = getIt.get<RestClient>();
  Future verifyOtp(Map<String, dynamic> requestBody) async {
    await restClient.verifyOtp(requestBody);
  }
}
