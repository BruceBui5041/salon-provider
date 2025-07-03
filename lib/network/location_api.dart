import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:salon_provider/model/request/location_req.dart';
import 'package:salon_provider/model/response/address_res.dart';
import 'package:salon_provider/model/response/common_response.dart';
import 'base_api_client.dart';

part 'location_api.g.dart';

@RestApi(baseUrl: '')
abstract class LocationApi extends BaseApiClient {
  factory LocationApi(Dio dio, {String? baseUrl}) = _LocationApi;

  @POST("/location/reverse-geocode")
  Future<BaseResponse<List<Address>>> reverseGeocode(
      @Body() ReverseGeocodeReq requestBody);

  @POST("/location/autocomplete")
  Future<BaseResponse<List<Address>>> autocomplete(
      @Body() AutoCompleteReq requestBody);

  @POST("/location/place-detail")
  Future<BaseResponse<Address>> geocodePlaceDetail(
      @Body() GeocodePlaceDetailReq requestBody);
}
