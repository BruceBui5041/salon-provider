import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'base_api_client.g.dart';

@RestApi(baseUrl: '')
abstract class BaseApiClient {
  factory BaseApiClient(Dio dio, {String? baseUrl}) = _BaseApiClient;
}
