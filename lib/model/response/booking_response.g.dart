// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Booking _$BookingFromJson(Map<String, dynamic> json) => Booking(
      id: json['id'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      serviceVersions: (json['service_versions'] as List<dynamic>?)
          ?.map((e) => ServiceVersion.fromJson(e as Map<String, dynamic>))
          .toList(),
      bookingStatus:
          $enumDecodeNullable(_$BookingStatusEnumMap, json['booking_status']),
      confirmedDate: json['confirmed_date'] == null
          ? null
          : DateTime.parse(json['confirmed_date'] as String),
      bookingDate: json['booking_date'] == null
          ? null
          : DateTime.parse(json['booking_date'] as String),
      duration: (json['duration'] as num?)?.toInt(),
      price: json['price'] as String?,
      discountedPrice: json['discounted_price'] as String?,
      discountAmount: json['discount_amount'] as String?,
      notes: json['notes'] as String?,
      completedAt: json['completed_at'] == null
          ? null
          : DateTime.parse(json['completed_at'] as String),
      cancellationReason: json['cancellation_reason'] as String?,
      cancelledAt: json['cancelled_at'] == null
          ? null
          : DateTime.parse(json['cancelled_at'] as String),
      payment: json['payment'] == null
          ? null
          : Payment.fromJson(json['payment'] as Map<String, dynamic>),
      serviceMan: json['service_man'] == null
          ? null
          : UserResponse.fromJson(json['service_man'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : UserResponse.fromJson(json['user'] as Map<String, dynamic>),
      coupon: json['coupon'] == null
          ? null
          : Coupon.fromJson(json['coupon'] as Map<String, dynamic>),
      commission: json['commission'] == null
          ? null
          : Commission.fromJson(json['commission'] as Map<String, dynamic>),
      isPopToHome: json['isPopToHome'] as bool? ?? false,
      bookingLocation: json['booking_location'] == null
          ? null
          : BookingLocation.fromJson(
              json['booking_location'] as Map<String, dynamic>),
      fees: (json['fees'] as List<dynamic>?)
          ?.map((e) => Fee.fromJson(e as Map<String, dynamic>))
          .toList(),
      travelFee: json['travel_fee'] as String?,
    );

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'status': instance.status,
      'service_versions': instance.serviceVersions,
      'booking_status': _$BookingStatusEnumMap[instance.bookingStatus],
      'confirmed_date': instance.confirmedDate?.toIso8601String(),
      'booking_date': instance.bookingDate?.toIso8601String(),
      'duration': instance.duration,
      'price': instance.price,
      'discounted_price': instance.discountedPrice,
      'discount_amount': instance.discountAmount,
      'notes': instance.notes,
      'completed_at': instance.completedAt?.toIso8601String(),
      'cancellation_reason': instance.cancellationReason,
      'cancelled_at': instance.cancelledAt?.toIso8601String(),
      'payment': instance.payment,
      'service_man': instance.serviceMan,
      'user': instance.user,
      'coupon': instance.coupon,
      'commission': instance.commission,
      'booking_location': instance.bookingLocation,
      'fees': instance.fees,
      'travel_fee': instance.travelFee,
      'isPopToHome': instance.isPopToHome,
    };

const _$BookingStatusEnumMap = {
  BookingStatus.pending: 'pending',
  BookingStatus.confirmed: 'confirmed',
  BookingStatus.inProgress: 'in_progress',
  BookingStatus.completed: 'completed',
  BookingStatus.cancelled: 'cancelled',
};
