import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'base_api_client.dart';

part 'notification_api.g.dart';

@RestApi(baseUrl: '')
abstract class NotificationApiClient extends BaseApiClient {
  factory NotificationApiClient(Dio dio, {String? baseUrl}) =
      _NotificationApiClient;

  @PATCH("notifications/{id}")
  Future<dynamic> getNotifications(@Path("id") String id);
}
