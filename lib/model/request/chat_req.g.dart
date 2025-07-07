// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessageWSBody _$ChatMessageWSBodyFromJson(Map<String, dynamic> json) =>
    ChatMessageWSBody(
      event: json['event'] as String,
      message: json['message'] as String,
      chatRoomId: json['chat_room_id'] as String,
    );

Map<String, dynamic> _$ChatMessageWSBodyToJson(ChatMessageWSBody instance) =>
    <String, dynamic>{
      'event': instance.event,
      'message': instance.message,
      'chat_room_id': instance.chatRoomId,
    };

CreateChatRoomReq _$CreateChatRoomReqFromJson(Map<String, dynamic> json) =>
    CreateChatRoomReq(
      name: json['name'] as String?,
      roomType: $enumDecode(_$RoomTypeEnumMap, json['room_type']),
      bookingId: json['booking_id'] as String?,
      participantIds: (json['participant_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CreateChatRoomReqToJson(CreateChatRoomReq instance) =>
    <String, dynamic>{
      'name': instance.name,
      'room_type': _$RoomTypeEnumMap[instance.roomType]!,
      'booking_id': instance.bookingId,
      'participant_ids': instance.participantIds,
    };

const _$RoomTypeEnumMap = {
  RoomType.direct: 'direct',
  RoomType.group: 'group',
  RoomType.booking: 'booking',
};

SendMessageReq _$SendMessageReqFromJson(Map<String, dynamic> json) =>
    SendMessageReq(
      roomId: json['room_id'] as String,
      content: json['content'] as String,
      messageType: $enumDecode(_$MessageTypeEnumMap, json['message_type']),
      event: json['event'] as String,
      replyToId: json['reply_to_id'] as String?,
    );

Map<String, dynamic> _$SendMessageReqToJson(SendMessageReq instance) =>
    <String, dynamic>{
      'event': instance.event,
      'room_id': instance.roomId,
      'content': instance.content,
      'message_type': _$MessageTypeEnumMap[instance.messageType]!,
      'reply_to_id': instance.replyToId,
    };

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
  MessageType.image: 'image',
  MessageType.file: 'file',
  MessageType.system: 'system',
};
