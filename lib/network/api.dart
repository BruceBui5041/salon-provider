import 'package:dio/dio.dart';
import 'package:fixit_provider/model/response/login_response.dart';
import 'package:json_annotation/json_annotation.dart';
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
}
