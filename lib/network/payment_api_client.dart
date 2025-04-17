import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:salon_provider/model/request/generate_qr_req.dart';
import 'package:salon_provider/model/response/bank_account_res.dart';
import 'package:salon_provider/model/response/bank_res.dart';
import 'package:salon_provider/model/response/base_response.dart';
import 'package:salon_provider/model/response/common_response.dart';
import 'base_api_client.dart';

part 'payment_api_client.g.dart';

@RestApi(baseUrl: '')
abstract class PaymentApiClient extends BaseApiClient {
  factory PaymentApiClient(Dio dio, {String? baseUrl}) = _PaymentApiClient;

  @POST("/payment/generateqr")
  Future<BaseResponse> genPaymentQrCode(
    @Body() GenerateQRReq requestBody,
  );

  @GET("/payment/banks")
  Future<BaseResponse<List<Bank>>> getBanks();
}
