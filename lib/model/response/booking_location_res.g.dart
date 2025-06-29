// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_location_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingLocation _$BookingLocationFromJson(Map<String, dynamic> json) =>
    BookingLocation(
      id: json['id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      status: json['status'] as String?,
      initialDistance: (json['initial_distance'] as num?)?.toInt(),
      initialDistanceText: json['initial_distance_text'] as String?,
      initialDuration: (json['initial_duration'] as num?)?.toInt(),
      initialDurationText: json['initial_duration_text'] as String?,
      booking: json['booking'] == null
          ? null
          : Booking.fromJson(json['booking'] as Map<String, dynamic>),
      serviceManAddress: json['service_man_address'] == null
          ? null
          : Address.fromJson(
              json['service_man_address'] as Map<String, dynamic>),
      customerAddress: json['customer_address'] == null
          ? null
          : Address.fromJson(json['customer_address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookingLocationToJson(BookingLocation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'status': instance.status,
      'initial_distance': instance.initialDistance,
      'initial_distance_text': instance.initialDistanceText,
      'initial_duration': instance.initialDuration,
      'initial_duration_text': instance.initialDurationText,
      'booking': instance.booking,
      'service_man_address': instance.serviceManAddress,
      'customer_address': instance.customerAddress,
    };
