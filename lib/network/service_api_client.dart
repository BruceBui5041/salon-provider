import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'base_api_client.dart';

part 'service_api_client.g.dart';

@RestApi(baseUrl: '')
abstract class ServiceApiClient extends BaseApiClient {
  factory ServiceApiClient(Dio dio, {String? baseUrl}) = _ServiceApiClient;

  @POST("/service")
  @MultiPart()
  Future<dynamic> createService(@Body() FormData? formData);

  @PUT("/service/{serviceId}")
  @MultiPart()
  Future<dynamic> updateCraftService(
      @Path("serviceId") String id, @Body() FormData? formData);

  @PATCH("/service/publish/{serviceId}")
  Future<dynamic> publishService(@Path("serviceId") String serviceId,
      @Body() Map<String, dynamic> requestBody);

  @PUT("/service/createdraft")
  Future<dynamic> createServiceCraft(@Body() Map<String, dynamic> requestBody);
}
