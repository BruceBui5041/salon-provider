import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:salon_provider/model/request/chat_req.dart';
import 'package:salon_provider/model/response/common_response.dart';
import 'package:salon_provider/model/response/chatroom_response.dart';
import 'base_api_client.dart';

part 'chat_api.g.dart';

@RestApi(baseUrl: '')
abstract class ChatApiClient extends BaseApiClient {
  factory ChatApiClient(Dio dio, {String? baseUrl}) = _ChatApiClient;

  @POST("/chatroom")
  Future<BaseResponse<ChatRoom>> createChatRoom(@Body() CreateChatRoomReq req);
}
