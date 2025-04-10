import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'base_api_client.dart';

part 'otp_api_client.g.dart';

@RestApi(baseUrl: '/otp')
abstract class OtpApiClient extends BaseApiClient {
  factory OtpApiClient(Dio dio, {String? baseUrl}) = _OtpApiClient;

  @POST("/verify")
  Future<dynamic> verifyOtp(@Body() Map<String, dynamic> requestBody);

  @POST("/resend")
  Future<dynamic> resendOtp();
}
