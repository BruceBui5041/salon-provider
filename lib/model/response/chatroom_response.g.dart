// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatroom_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoom _$ChatRoomFromJson(Map<String, dynamic> json) => ChatRoom(
      id: json['id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      status: json['status'] as String?,
      roomStatus: $enumDecodeNullable(_$RoomStatusEnumMap, json['room_status']),
      roomType: $enumDecodeNullable(_$RoomTypeEnumMap, json['room_type']),
      bookingId: json['booking_id'] as String?,
      booking: json['booking'] == null
          ? null
          : Booking.fromJson(json['booking'] as Map<String, dynamic>),
      name: json['name'] as String?,
      lastMessageId: json['last_message_id'] as String?,
      lastActivityAt: json['last_activity_at'] == null
          ? null
          : DateTime.parse(json['last_activity_at'] as String),
      shardKey: (json['shard_key'] as num?)?.toInt(),
      participants: (json['participants'] as List<dynamic>?)
          ?.map((e) => ChatRoomParticipant.fromJson(e as Map<String, dynamic>))
          .toList(),
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatRoomToJson(ChatRoom instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'status': instance.status,
      'room_status': _$RoomStatusEnumMap[instance.roomStatus],
      'room_type': _$RoomTypeEnumMap[instance.roomType],
      'booking_id': instance.bookingId,
      'booking': instance.booking,
      'name': instance.name,
      'last_message_id': instance.lastMessageId,
      'last_activity_at': instance.lastActivityAt?.toIso8601String(),
      'shard_key': instance.shardKey,
      'participants': instance.participants,
      'messages': instance.messages,
    };

const _$RoomStatusEnumMap = {
  RoomStatus.active: 'active',
  RoomStatus.inactive: 'inactive',
  RoomStatus.archived: 'archived',
};

const _$RoomTypeEnumMap = {
  RoomType.direct: 'direct',
  RoomType.group: 'group',
  RoomType.booking: 'booking',
};

ChatRoomParticipant _$ChatRoomParticipantFromJson(Map<String, dynamic> json) =>
    ChatRoomParticipant(
      id: json['id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      status: json['status'] as String?,
      roomId: json['room_id'] as String?,
      room: json['room'] == null
          ? null
          : ChatRoom.fromJson(json['room'] as Map<String, dynamic>),
      userId: json['user_id'] as String?,
      user: json['user'] == null
          ? null
          : UserResponse.fromJson(json['user'] as Map<String, dynamic>),
      role: $enumDecodeNullable(_$ParticipantRoleEnumMap, json['role']),
      joinedAt: json['joined_at'] == null
          ? null
          : DateTime.parse(json['joined_at'] as String),
      lastReadMessageId: json['last_read_message_id'] as String?,
      isMuted: json['is_muted'] as bool?,
      shardKey: (json['shard_key'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ChatRoomParticipantToJson(
        ChatRoomParticipant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'status': instance.status,
      'room_id': instance.roomId,
      'room': instance.room,
      'user_id': instance.userId,
      'user': instance.user,
      'role': _$ParticipantRoleEnumMap[instance.role],
      'joined_at': instance.joinedAt?.toIso8601String(),
      'last_read_message_id': instance.lastReadMessageId,
      'is_muted': instance.isMuted,
      'shard_key': instance.shardKey,
    };

const _$ParticipantRoleEnumMap = {
  ParticipantRole.member: 'member',
  ParticipantRole.admin: 'admin',
};

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => ChatMessage(
      id: json['id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      status: json['status'] as String?,
      roomId: json['room_id'] as String?,
      room: json['room'] == null
          ? null
          : ChatRoom.fromJson(json['room'] as Map<String, dynamic>),
      senderId: json['sender_id'] as String?,
      sender: json['sender'] == null
          ? null
          : UserResponse.fromJson(json['sender'] as Map<String, dynamic>),
      messageType:
          $enumDecodeNullable(_$MessageTypeEnumMap, json['message_type']),
      content: json['content'] as String?,
      fileUrl: json['file_url'] as String?,
      fileType: json['file_type'] as String?,
      fileSize: (json['file_size'] as num?)?.toInt(),
      isDeleted: json['is_deleted'] as bool?,
      replyToId: json['reply_to_id'] as String?,
      replyTo: json['reply_to'] == null
          ? null
          : ChatMessage.fromJson(json['reply_to'] as Map<String, dynamic>),
      shardKey: (json['shard_key'] as num?)?.toInt(),
      readBy: (json['read_by'] as List<dynamic>?)
          ?.map((e) => ChatMessageRead.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'status': instance.status,
      'room_id': instance.roomId,
      'room': instance.room,
      'sender_id': instance.senderId,
      'sender': instance.sender,
      'message_type': _$MessageTypeEnumMap[instance.messageType],
      'content': instance.content,
      'file_url': instance.fileUrl,
      'file_type': instance.fileType,
      'file_size': instance.fileSize,
      'is_deleted': instance.isDeleted,
      'reply_to_id': instance.replyToId,
      'reply_to': instance.replyTo,
      'shard_key': instance.shardKey,
      'read_by': instance.readBy,
    };

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
  MessageType.image: 'image',
  MessageType.file: 'file',
  MessageType.system: 'system',
};

ChatMessageRead _$ChatMessageReadFromJson(Map<String, dynamic> json) =>
    ChatMessageRead(
      id: json['id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      status: json['status'] as String?,
      messageId: json['message_id'] as String?,
      message: json['message'] == null
          ? null
          : ChatMessage.fromJson(json['message'] as Map<String, dynamic>),
      userId: json['user_id'] as String?,
      user: json['user'] == null
          ? null
          : UserResponse.fromJson(json['user'] as Map<String, dynamic>),
      readAt: json['read_at'] == null
          ? null
          : DateTime.parse(json['read_at'] as String),
      shardKey: (json['shard_key'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ChatMessageReadToJson(ChatMessageRead instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'status': instance.status,
      'message_id': instance.messageId,
      'message': instance.message,
      'user_id': instance.userId,
      'user': instance.user,
      'read_at': instance.readAt?.toIso8601String(),
      'shard_key': instance.shardKey,
    };
