// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationRes _$NotificationResFromJson(Map<String, dynamic> json) =>
    NotificationRes(
      id: json['id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      status: json['status'] as String?,
      type: json['type'] as String?,
      scheduled: json['scheduled'] == null
          ? null
          : DateTime.parse(json['scheduled'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
      booking: json['booking'] == null
          ? null
          : Booking.fromJson(json['booking'] as Map<String, dynamic>),
    )..details = (json['details'] as List<dynamic>?)
        ?.map((e) => NotificationDetailsRes.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$NotificationResToJson(NotificationRes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'status': instance.status,
      'type': instance.type,
      'scheduled': instance.scheduled?.toIso8601String(),
      'metadata': instance.metadata,
      'details': instance.details,
      'booking': instance.booking,
    };
