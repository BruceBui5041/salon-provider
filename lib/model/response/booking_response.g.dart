// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingResponse _$BookingResponseFromJson(Map<String, dynamic> json) =>
    BookingResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => ItemBooking.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookingResponseToJson(BookingResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

ItemBooking _$ItemBookingFromJson(Map<String, dynamic> json) => ItemBooking(
      id: json['id'] as String?,
      status: json['status'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      serviceVersions: (json['serviceVersions'] as List<dynamic>)
          .map((e) => ServiceVersion.fromJson(e as Map<String, dynamic>))
          .toList(),
      bookingStatus: json['bookingStatus'] as String,
      confirmedDate: DateTime.parse(json['confirmedDate'] as String),
      bookingDate: DateTime.parse(json['bookingDate'] as String),
      duration: (json['duration'] as num).toInt(),
      price: json['price'] as String,
      discountedPrice: json['discountedPrice'] as String,
      discountAmount: json['discountAmount'] as String,
      notes: json['notes'] as String,
      completedAt: DateTime.parse(json['completedAt'] as String),
      cancellationReason: json['cancellationReason'] as String,
      cancelledAt: DateTime.parse(json['cancelledAt'] as String),
    );

Map<String, dynamic> _$ItemBookingToJson(ItemBooking instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'serviceVersions': instance.serviceVersions,
      'bookingStatus': instance.bookingStatus,
      'confirmedDate': instance.confirmedDate.toIso8601String(),
      'bookingDate': instance.bookingDate.toIso8601String(),
      'duration': instance.duration,
      'price': instance.price,
      'discountedPrice': instance.discountedPrice,
      'discountAmount': instance.discountAmount,
      'notes': instance.notes,
      'completedAt': instance.completedAt.toIso8601String(),
      'cancellationReason': instance.cancellationReason,
      'cancelledAt': instance.cancelledAt.toIso8601String(),
    };
