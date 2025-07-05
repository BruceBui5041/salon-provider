import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:salon_provider/model/request/update_profile.dart';
import 'package:salon_provider/model/response/common_response.dart';
import 'package:salon_provider/model/response/earning_response.dart';
import 'base_api_client.dart';

part 'user_api_client.g.dart';

@RestApi(baseUrl: '')
abstract class UserApiClient extends BaseApiClient {
  factory UserApiClient(Dio dio, {String? baseUrl}) = _UserApiClient;

  @POST("/userdevice")
  Future<void> saveUserDevice(@Body() Map<String, dynamic> requestBody);

  @PATCH("/user/{id}")
  @MultiPart()
  Future<BaseResponse<bool>> updateUserProfile(
    @Path("id") String id,
    @Body() FormData requestBody,
  );

  @GET("/user/provider-earnings")
  Future<BaseResponse<ProviderEarningResponse>> getProviderEarnings(
      {@Query("year") int? year,
      @Query("month") int? month,
      @Query("user_id") String? userId});

  @PATCH("/user/{id}")
  Future<BaseResponse<bool>> updateUserStatus(
    @Path("id") String id,
    @Body() UpdateUserStatusRequest requestBody,
  );
}
