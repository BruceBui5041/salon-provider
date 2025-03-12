import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fixit_provider/model/response/check_auth_response.dart';
import 'package:fixit_provider/model/response/login_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api.g.dart';

@RestApi(baseUrl: '')
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @POST("/register")
  Future<dynamic> registerUser(@Body() Map<String, dynamic> requestBody);

  @POST("/otp/verify")
  Future<dynamic> verifyOtp(@Body() Map<String, dynamic> requestBody);

  @POST("/login")
  Future<LoginResponse> loginUser(@Body() Map<String, dynamic> requestBody);

  @POST("/otp/resend")
  Future<dynamic> resendOtp();

  @POST("/service")
  @MultiPart()
  Future<dynamic> createService(@Body() FormData? formData);

  @GET("/checkauth")
  Future<CheckAuthResponse> checkAuth();

  @PATCH("/service/publish/{serviceId}")
  Future<dynamic> publishService(@Path("serviceId") String serviceId,
      @Body() Map<String, dynamic> requestBody);

  @PUT("/service/createdraft")
  Future<dynamic> createServiceCraft(@Body() Map<String, dynamic> requestBody);
}
