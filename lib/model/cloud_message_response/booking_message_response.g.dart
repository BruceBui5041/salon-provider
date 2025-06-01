// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_message_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingNotificationMessage _$BookingNotificationMessageFromJson(
        Map<String, dynamic> json) =>
    BookingNotificationMessage(
      bookingId: json['booking_id'] as String?,
      userId: json['user_id'] as String?,
      serviceVersionIds: json['service_version_ids'] as String?,
      serviceIds: json['service_ids'] as String?,
      serviceManId: json['service_man_id'] as String?,
      event: json['event'] as String?,
    );

Map<String, dynamic> _$BookingNotificationMessageToJson(
        BookingNotificationMessage instance) =>
    <String, dynamic>{
      'event': instance.event,
      'booking_id': instance.bookingId,
      'user_id': instance.userId,
      'service_version_ids': instance.serviceVersionIds,
      'service_man_id': instance.serviceManId,
      'service_ids': instance.serviceIds,
    };
