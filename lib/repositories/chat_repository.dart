import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/config/repository_config.dart';
import 'package:salon_provider/model/request/chat_req.dart' as req;
import 'package:salon_provider/model/request/search_request_model.dart';
import 'package:salon_provider/model/response/booking_response.dart';
import 'package:salon_provider/model/response/chatroom_response.dart';
import 'package:salon_provider/model/response/common_response.dart';
import 'package:salon_provider/network/api.dart';
import 'package:salon_provider/network/chat_api.dart';
import 'package:salon_provider/network/ws_api.dart';

class ChatRepository extends RepositoryConfig {
  final chatClient = getIt.get<ChatApiClient>();
  final wsApi = getIt.get<WebSocketApi>();

  Future<BaseResponse<ChatRoom>> createChatRoom(
      String userId, String serviceManId) async {
    var body = req.CreateChatRoomReq(
      roomType: req.RoomType.booking,
      participantIds: [userId, serviceManId],
    );
    var response = await chatClient.createChatRoom(body);
    return response;
  }

  Future<BaseResponse<ChatRoom>> createChatRoomWithBooking(
      String userId, String customerId, String bookingId) async {
    var body = req.CreateChatRoomReq(
      roomType: req.RoomType.booking,
      participantIds: [userId, customerId],
      bookingId: bookingId,
    );
    var response = await chatClient.createChatRoom(body);
    return response;
  }

  Future<List<ChatRoom>> getChatRoomsByRecipient(String recipientId) async {
    var body = SearchRequestBody(model: "chat_room", conditions: [
      [
        Condition(
            source: "participants.user_id", operator: "=", target: recipientId),
      ]
    ], fields: [
      FieldItem(field: "participants.user"),
      FieldItem(field: "booking"),
    ]);
    var response = await commonRestClient.search<List<ChatRoom>>(body.toJson());
    var res =
        (response as List<dynamic>).map((e) => ChatRoom.fromJson(e)).toList();
    return res;
  }

  Future<List<ChatRoom>> getChatRoomsByBooking(String bookingId) async {
    var body = SearchRequestBody(model: "chat_room", conditions: [
      [
        Condition(source: "booking_id", operator: "=", target: bookingId),
      ]
    ], fields: [
      FieldItem(field: "participants.user"),
      FieldItem(field: "booking"),
    ]);
    var response = await commonRestClient.search<List<ChatRoom>>(body.toJson());
    var res =
        (response as List<dynamic>).map((e) => ChatRoom.fromJson(e)).toList();
    return res;
  }

  Future<ChatRoom?> getChatRoomById(String roomId) async {
    var body = SearchRequestBody(model: "chat_room", conditions: [
      [
        Condition(source: "id", operator: "=", target: roomId),
      ]
    ], fields: [
      FieldItem(field: "participants.user"),
      FieldItem(field: "booking"),
    ]);
    var response = await commonRestClient.search<List<ChatRoom>>(body.toJson());
    if ((response as List<dynamic>).isEmpty) return null;
    return ChatRoom.fromJson(response.first);
  }

  Future<Booking?> getBookingById(String bookingId) async {
    var body = SearchRequestBody(model: "booking", conditions: [
      [
        Condition(source: "id", operator: "=", target: bookingId),
      ]
    ], fields: [
      FieldItem(field: "user"),
      FieldItem(field: "user.user_profile"),
      FieldItem(field: "service_man"),
    ]);
    final response =
        await commonRestClient.search<List<Booking>>(body.toJson());
    if ((response as List<dynamic>).isEmpty) return null;
    return Booking.fromJson(response.first);
  }

  Future<String?> getCustomerIdFromBooking(String bookingId) async {
    final booking = await getBookingById(bookingId);
    return booking?.user?.id;
  }

  Future<List<ChatMessage>> getMessagesByRoom(String roomId,
      {int? limit, int? offset}) async {
    var body = SearchRequestBody(
      model: "chat_message",
      conditions: [
        [
          Condition(source: "room_id", operator: "=", target: roomId),
        ]
      ],
      fields: [
        FieldItem(field: "sender"),
        FieldItem(field: "reply_to"),
        FieldItem(field: "read_by"),
      ],
      orderBy: "created_at desc",
      limit: limit,
      offset: offset,
    );
    var response =
        await commonRestClient.search<List<ChatMessage>>(body.toJson());
    var res = (response as List<dynamic>)
        .map((e) => ChatMessage.fromJson(e))
        .toList();
    return res;
  }

  Future<bool> sendMessage(
    String roomId,
    String content,
  ) async {
    try {
      var body = req.SendMessageReq(
        event: 'chat_message',
        roomId: roomId,
        content: content,
        messageType: MessageType.text,
      );
      wsApi.send(body.toJson());

      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> markMessageAsRead(String messageId) async {
    try {
      wsApi.send({
        'event': 'chat_mark_read',
        'message_id': messageId,
      });

      return true;
    } catch (e) {
      rethrow;
    }
  }
}
