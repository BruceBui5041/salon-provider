import 'dart:developer';

import 'package:salon_provider/common/Utils.dart';
import 'package:salon_provider/config.dart';
import 'package:salon_provider/config/auth_config.dart';
import 'package:salon_provider/config/constant_api_config.dart';
import 'package:salon_provider/config/cookie_config.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/config/repository_config.dart';
import 'package:salon_provider/model/response/common_response.dart';
import 'package:salon_provider/model/response/login_response.dart';
import 'package:salon_provider/model/response/user_response.dart';
import 'package:salon_provider/network/api.dart';
import 'package:dio/dio.dart';
import 'package:salon_provider/network/api_config.dart';
import 'package:salon_provider/network/ws_api.dart';

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
      log(e.toString());
    }
  }

  Future<UserResponse?> checkAuth() async {
    try {
      await CookieConfig.setCookieToApi(Uri.parse(ConstantApiConfig().getUrl));

      var res = await restClient.checkAuth();
      if (res.data == null) throw Exception("User not found");

      await AuthConfig.setUser(res.data!);

      if (!getIt.get<WebSocketApi>().isConnected) {
        var userId = await AuthConfig.getUserId();
        await ApiConfig.connectWebSocket(
          endpoint: 'ws',
          queryParams: {
            'user_id': userId,
          },
        );
      }

      return res.data;
    } catch (e) {
      if (e is DioException) {
        Utils.error(e);
      }
    }
    return null;
  }
}
