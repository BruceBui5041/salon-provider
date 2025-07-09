import 'package:json_annotation/json_annotation.dart';
import 'package:salon_provider/model/response/base_response.dart';
import 'package:salon_provider/model/response/booking_response.dart';
import 'package:salon_provider/model/response/user_response.dart';

part 'chatroom_response.g.dart';

enum RoomType {
  @JsonValue('direct')
  direct,
  @JsonValue('group')
  group,
  @JsonValue('booking')
  booking
}

enum RoomStatus {
  @JsonValue('active')
  active,
  @JsonValue('inactive')
  inactive,
  @JsonValue('archived')
  archived
}

enum ParticipantRole {
  @JsonValue('member')
  member,
  @JsonValue('admin')
  admin
}

enum MessageType {
  @JsonValue('text')
  text,
  @JsonValue('image')
  image,
  @JsonValue('file')
  file,
  @JsonValue('system')
  system
}

@JsonSerializable()
class ChatRoom extends CommonResponse {
  @JsonKey(name: 'room_status')
  final RoomStatus? roomStatus;

  @JsonKey(name: 'room_type')
  final RoomType? roomType;

  @JsonKey(name: 'booking_id')
  final String? bookingId;

  @JsonKey(name: 'booking')
  final Booking? booking;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'last_message_id')
  final String? lastMessageId;

  @JsonKey(name: 'last_message')
  final ChatMessage? lastMessage;

  @JsonKey(name: 'last_activity_at')
  final DateTime? lastActivityAt;

  @JsonKey(name: 'shard_key')
  final int? shardKey;

  @JsonKey(name: 'participants')
  final List<ChatRoomParticipant>? participants;

  @JsonKey(name: 'messages')
  final List<ChatMessage>? messages;

  ChatRoom({
    super.id,
    super.createdAt,
    super.updatedAt,
    super.status,
    this.roomStatus,
    this.roomType,
    this.bookingId,
    this.booking,
    this.name,
    this.lastMessageId,
    this.lastMessage,
    this.lastActivityAt,
    this.shardKey,
    this.participants,
    this.messages,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomToJson(this);
}

@JsonSerializable()
class ChatRoomParticipant extends CommonResponse {
  @JsonKey(name: 'room_id')
  final String? roomId;

  @JsonKey(name: 'room')
  final ChatRoom? room;

  @JsonKey(name: 'user_id')
  final String? userId;

  @JsonKey(name: 'user')
  final UserResponse? user;

  @JsonKey(name: 'role')
  final ParticipantRole? role;

  @JsonKey(name: 'joined_at')
  final DateTime? joinedAt;

  @JsonKey(name: 'last_read_message_id')
  final String? lastReadMessageId;

  @JsonKey(name: 'is_muted')
  final bool? isMuted;

  @JsonKey(name: 'shard_key')
  final int? shardKey;

  ChatRoomParticipant({
    super.id,
    super.createdAt,
    super.updatedAt,
    super.status,
    this.roomId,
    this.room,
    this.userId,
    this.user,
    this.role,
    this.joinedAt,
    this.lastReadMessageId,
    this.isMuted,
    this.shardKey,
  });

  factory ChatRoomParticipant.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomParticipantFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomParticipantToJson(this);
}

@JsonSerializable()
class ChatMessage extends CommonResponse {
  @JsonKey(name: 'room_id')
  final String? roomId;

  @JsonKey(name: 'room')
  final ChatRoom? room;

  @JsonKey(name: 'sender_id')
  final String? senderId;

  @JsonKey(name: 'sender')
  final UserResponse? sender;

  @JsonKey(name: 'message_type')
  final MessageType? messageType;

  @JsonKey(name: 'content')
  final String? content;

  @JsonKey(name: 'file_url')
  final String? fileUrl;

  @JsonKey(name: 'file_type')
  final String? fileType;

  @JsonKey(name: 'file_size')
  final int? fileSize;

  @JsonKey(name: 'is_deleted')
  final bool? isDeleted;

  @JsonKey(name: 'reply_to_id')
  final String? replyToId;

  @JsonKey(name: 'reply_to')
  final ChatMessage? replyTo;

  @JsonKey(name: 'shard_key')
  final int? shardKey;

  @JsonKey(name: 'read_by')
  final List<ChatMessageRead>? readBy;

  ChatMessage({
    super.id,
    super.createdAt,
    super.updatedAt,
    super.status,
    this.roomId,
    this.room,
    this.senderId,
    this.sender,
    this.messageType,
    this.content,
    this.fileUrl,
    this.fileType,
    this.fileSize,
    this.isDeleted,
    this.replyToId,
    this.replyTo,
    this.shardKey,
    this.readBy,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
}

@JsonSerializable()
class ChatMessageRead extends CommonResponse {
  @JsonKey(name: 'message_id')
  final String? messageId;

  @JsonKey(name: 'message')
  final ChatMessage? message;

  @JsonKey(name: 'user_id')
  final String? userId;

  @JsonKey(name: 'user')
  final UserResponse? user;

  @JsonKey(name: 'read_at')
  final DateTime? readAt;

  @JsonKey(name: 'shard_key')
  final int? shardKey;

  ChatMessageRead({
    super.id,
    super.createdAt,
    super.updatedAt,
    super.status,
    this.messageId,
    this.message,
    this.userId,
    this.user,
    this.readAt,
    this.shardKey,
  });

  factory ChatMessageRead.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageReadFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageReadToJson(this);
}
