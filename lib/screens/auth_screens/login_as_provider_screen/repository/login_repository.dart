import 'package:fixit_provider/config/injection_config.dart';
import 'package:fixit_provider/config/repository_config.dart';
import 'package:fixit_provider/model/response/login_response.dart';
import 'package:fixit_provider/network/api.dart';

class LoginScreenRepository extends RepositoryConfig {
  var restClient = getIt.get<RestClient>();
  Future<LoginResponse> loginUser(String phoneNumber) async {
    return await restClient
        .loginUser({"auth_type": "phone_number", "phone_number": phoneNumber});
  }

  Future<void> resendOtp() async {
    return await restClient.resendOtp();
  }
}
