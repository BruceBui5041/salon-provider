import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:salon_provider/model/request/address_req.dart';
import 'package:salon_provider/model/response/address_res.dart';
import 'package:salon_provider/model/response/common_response.dart';

part 'address_api.g.dart';

@RestApi(baseUrl: '')
abstract class AddressApi {
  factory AddressApi(Dio dio, {String? baseUrl}) = _AddressApi;

  @POST("/address")
  Future<BaseResponse<Address>> createAddress(@Body() dynamic requestBody);

  @PATCH("/address/{id}")
  Future<BaseResponse<Address>> updateAddress(
      @Path() String id, @Body() dynamic requestBody);

  @DELETE("/address/{id}")
  Future<BaseResponse<dynamic>> deleteAddress(@Path() String id);

  @POST("/address/choose-current")
  Future<BaseResponse<bool>> chooseCurrentAddress(
      @Body() ChooseCurrentAddressReq requestBody);
}
