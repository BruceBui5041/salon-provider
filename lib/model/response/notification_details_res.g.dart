// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_details_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationDetailsRes _$NotificationDetailsResFromJson(
        Map<String, dynamic> json) =>
    NotificationDetailsRes(
      id: json['id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      status: json['status'] as String?,
      state: json['state'] as String?,
      sendAt: json['send_at'] == null
          ? null
          : DateTime.parse(json['send_at'] as String),
      error: json['error'] as String?,
      readAt: json['read_at'] as String?,
      user: json['user'] == null
          ? null
          : UserResponse.fromJson(json['user'] as Map<String, dynamic>),
      notification: json['notification'] == null
          ? null
          : NotificationRes.fromJson(
              json['notification'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotificationDetailsResToJson(
        NotificationDetailsRes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'status': instance.status,
      'state': instance.state,
      'send_at': instance.sendAt?.toIso8601String(),
      'error': instance.error,
      'read_at': instance.readAt,
      'user': instance.user,
      'notification': instance.notification,
    };
