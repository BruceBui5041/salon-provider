import 'package:json_annotation/json_annotation.dart';
import 'package:salon_provider/model/response/chatroom_response.dart';

part 'chat_req.g.dart';

@JsonSerializable()
class ChatMessageWSBody {
  @JsonKey(name: "event")
  final String event;
  @JsonKey(name: "message")
  final String message;
  @JsonKey(name: "chat_room_id")
  final String chatRoomId;

  ChatMessageWSBody({
    required this.event,
    required this.message,
    required this.chatRoomId,
  });

  factory ChatMessageWSBody.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageWSBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageWSBodyToJson(this);
}

enum RoomType {
  @JsonValue("direct")
  direct,
  @JsonValue("group")
  group,
  @JsonValue("booking")
  booking,
}

@JsonSerializable()
class CreateChatRoomReq {
  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'room_type')
  final RoomType roomType;

  @JsonKey(name: 'booking_id')
  final String? bookingId;

  @JsonKey(name: 'participant_ids')
  final List<String> participantIds;

  CreateChatRoomReq({
    this.name,
    required this.roomType,
    this.bookingId,
    required this.participantIds,
  });

  factory CreateChatRoomReq.fromJson(Map<String, dynamic> json) =>
      _$CreateChatRoomReqFromJson(json);

  Map<String, dynamic> toJson() => _$CreateChatRoomReqToJson(this);
}

@JsonSerializable()
class SendMessageReq {
  @JsonKey(name: 'event')
  final String event;

  @JsonKey(name: 'room_id')
  final String roomId;

  @JsonKey(name: 'content')
  final String content;

  @JsonKey(name: 'message_type')
  final MessageType messageType;

  @JsonKey(name: 'reply_to_id')
  final String? replyToId;

  SendMessageReq({
    required this.roomId,
    required this.content,
    required this.messageType,
    required this.event,
    this.replyToId,
  });

  factory SendMessageReq.fromJson(Map<String, dynamic> json) =>
      _$SendMessageReqFromJson(json);

  Map<String, dynamic> toJson() => _$SendMessageReqToJson(this);
}
