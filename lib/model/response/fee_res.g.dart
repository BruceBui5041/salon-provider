// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fee_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fee _$FeeFromJson(Map<String, dynamic> json) => Fee(
      id: json['id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      status: json['status'] as String?,
      type: $enumDecodeNullable(_$FeeTypeEnumMap, json['type']),
      creator: json['creator'] == null
          ? null
          : UserResponse.fromJson(json['creator'] as Map<String, dynamic>),
      role: json['role'] == null
          ? null
          : RoleResponse.fromJson(json['role'] as Map<String, dynamic>),
      publishedAt: json['published_at'] == null
          ? null
          : DateTime.parse(json['published_at'] as String),
      bookings: (json['bookings'] as List<dynamic>?)
          ?.map((e) => Booking.fromJson(e as Map<String, dynamic>))
          .toList(),
      travelFeePerKm: json['travel_fee_per_km'] as String?,
      freeTravelFeeAt: json['free_travel_fee_at'] as String?,
    );

Map<String, dynamic> _$FeeToJson(Fee instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'status': instance.status,
      'type': _$FeeTypeEnumMap[instance.type],
      'creator': instance.creator,
      'role': instance.role,
      'published_at': instance.publishedAt?.toIso8601String(),
      'bookings': instance.bookings,
      'travel_fee_per_km': instance.travelFeePerKm,
      'free_travel_fee_at': instance.freeTravelFeeAt,
    };

const _$FeeTypeEnumMap = {
  FeeType.platformFee: 'platform_fee',
  FeeType.travelFeePerKm: 'travel_fee_per_km',
};
