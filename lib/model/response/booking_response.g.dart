// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemBooking _$ItemBookingFromJson(Map<String, dynamic> json) => ItemBooking(
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
      bookingStatus: json['booking_status'] as String?,
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
          : ServiceManResponse.fromJson(
              json['service_man'] as Map<String, dynamic>),
      coupon: json['coupon'] == null
          ? null
          : ItemCoupon.fromJson(json['coupon'] as Map<String, dynamic>),
      isPopToHome: json['isPopToHome'] as bool? ?? false,
    );

Map<String, dynamic> _$ItemBookingToJson(ItemBooking instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'service_versions': instance.serviceVersions,
      'booking_status': instance.bookingStatus,
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
      'coupon': instance.coupon,
      'isPopToHome': instance.isPopToHome,
    };
