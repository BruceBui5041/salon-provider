import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:salon_provider/model/response/gen_qr_response.dart';
import 'base_api_client.dart';

part 'payment_api_client.g.dart';

@RestApi(baseUrl: '')
abstract class PaymentApiClient extends BaseApiClient {
  factory PaymentApiClient(Dio dio, {String? baseUrl}) = _PaymentApiClient;

  @POST("/payment/generateqr")
  Future<GenQrResponse> getGenQrCode(@Body() Map<String, dynamic> requestBody);
}
