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
import 'package:salon_provider/common/enum_value.dart';

class ChatRepository extends RepositoryConfig {
  final chatClient = getIt.get<ChatApiClient>();
  final wsApi = getIt.get<WebSocketApi>();

  Future<BaseResponse<ChatRoom>> createChatRoomWithBooking(
      String userId, String customerId, String bookingId) async {
    // First get booking details to include in the room name
    Booking? booking = await getBookingById(bookingId);
    String roomName = "";

    if (booking != null) {
      // Create room name from user name and service title
      String userName =
          "${booking.user?.firstname ?? ""} ${booking.user?.lastname ?? ""}"
              .trim();
      if (userName.isEmpty) {
        userName = "User";
      }

      String serviceTitle = "";
      if (booking.serviceVersions != null &&
          booking.serviceVersions!.isNotEmpty) {
        serviceTitle = booking.serviceVersions!.first.title ?? "";
      }

      roomName =
          serviceTitle.isNotEmpty ? "$userName - $serviceTitle" : userName;
    }

    var body = req.CreateChatRoomReq(
      roomType: req.RoomType.booking,
      participantIds: [userId, customerId],
      bookingId: bookingId,
      name: roomName.isNotEmpty ? roomName : null,
    );
    var response = await chatClient.createChatRoom(body);
    return response;
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

  Future<Booking?> getBookingById(String bookingId) async {
    var body = SearchRequestBody(model: "booking", conditions: [
      [
        Condition(source: "id", operator: "=", target: bookingId),
      ]
    ], fields: [
      FieldItem(field: "user"),
      FieldItem(field: "user.user_profile"),
      FieldItem(field: "service_man"),
      FieldItem(field: "service_versions"),
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

  Future<List<ChatMessage>> getMessagesByRoomWithLastMessage(
    String roomId,
    String? lastMessageId, {
    int limit = 20,
    bool isFirstLoad = true,
    String? earliestMessageId,
  }) async {
    List<Condition> conditions = [
      Condition(source: "room_id", operator: "=", target: roomId),
    ];

    // For first load, get messages up to last_message_id
    if (isFirstLoad && lastMessageId != null) {
      conditions.add(
        Condition(source: "id", operator: "<=", target: lastMessageId),
      );
    }
    // For loading more, get messages before the earliest message we have
    else if (!isFirstLoad && earliestMessageId != null) {
      conditions.add(
        Condition(source: "id", operator: "<", target: earliestMessageId),
      );
    }

    var body = SearchRequestBody(
      model: "chat_message",
      conditions: [conditions],
      fields: [
        FieldItem(field: "sender"),
        FieldItem(field: "reply_to"),
        FieldItem(field: "read_by"),
      ],
      orderBy: "created_at desc",
      limit: limit,
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
        event: WebSocketEventEnum.chat_message.value,
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
        'event': WebSocketEventEnum.chat_mark_read.value,
        'message_id': messageId,
      });

      return true;
    } catch (e) {
      rethrow;
    }
  }
}
