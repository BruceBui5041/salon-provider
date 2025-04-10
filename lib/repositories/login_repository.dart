import 'package:salon_provider/common/Utils.dart';
import 'package:salon_provider/config.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/config/repository_config.dart';
import 'package:salon_provider/model/response/check_auth_response.dart';
import 'package:salon_provider/model/response/common_response.dart';
import 'package:salon_provider/model/response/login_response.dart';
import 'package:salon_provider/network/api.dart';
import 'package:dio/dio.dart';

class LoginScreenRepository extends RepositoryConfig {
  var restClient = getIt.get<AuthApiClient>();
  Future<BaseResponse<LoginItem>> loginUser(String phoneNumber) async {
    return await restClient
        .loginUser({"auth_type": "phone_number", "phone_number": phoneNumber});
  }

  Future<BaseResponse<bool>> logoutUser() async {
    return await restClient.logoutUser();
  }

  Future<void> resendOtp(BuildContext context) async {
    try {
      var otpClient = getIt.get<OtpApiClient>();
      await otpClient.resendOtp();
    } catch (e) {
      print(e);
    }
  }

  Future<CheckAuthResponse?> checkAuth() async {
    try {
      var res = await restClient.checkAuth();
      return res;
    } catch (e) {
      if (e is DioException) {
        Utils.error(e);
      }
      print(e);
    }
    return null;
  }
}
