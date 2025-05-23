import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:salon_provider/model/request/cancel_req.dart';
import 'package:salon_provider/model/response/common_response.dart';
import 'base_api_client.dart';

part 'booking_api_client.g.dart';

@RestApi(baseUrl: '')
abstract class BookingApiClient extends BaseApiClient {
  factory BookingApiClient(Dio dio, {String? baseUrl}) = _BookingApiClient;

  @PATCH("/booking/cancel/{id}")
  Future<BaseResponse<bool>> cancelBooking(
      @Path("id") String id, @Body() CancelReq requestBody);

  @PATCH("/booking/accept/{id}")
  Future<BaseResponse<bool>> acceptBooking(@Path("id") String id);

  @PATCH("/booking/complete/{id}")
  Future<BaseResponse<bool>> completeBooking(@Path("id") String id);

  @PATCH("/booking/inprogress/{id}")
  Future<BaseResponse<bool>> inProgressBooking(@Path("id") String id);

  @PATCH("/booking/paid/{id}")
  Future<BaseResponse<bool>> paidBooking(@Path("id") String id);
}
