import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:salon_provider/model/response/check_auth_response.dart';
import 'package:salon_provider/model/response/login_response.dart';
import 'package:salon_provider/model/response/common_response.dart';
import 'base_api_client.dart';

part 'auth_api_client.g.dart';

@RestApi(baseUrl: '')
abstract class AuthApiClient extends BaseApiClient {
  factory AuthApiClient(Dio dio, {String? baseUrl}) = _AuthApiClient;

  @POST("/register")
  Future<dynamic> registerUser(@Body() Map<String, dynamic> requestBody);

  @POST("/login")
  Future<BaseResponse<LoginItem>> loginUser(
      @Body() Map<String, dynamic> requestBody);

  @POST("/logout")
  Future<BaseResponse<bool>> logoutUser();

  @GET("/checkauth")
  Future<CheckAuthResponse> checkAuth();
}
