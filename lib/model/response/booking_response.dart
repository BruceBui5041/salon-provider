// To parse this JSON data, do
//
//     final bookingResponse = bookingResponseFromJson(jsonString);

import 'package:fixit_provider/model/response/service_version_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
part 'booking_response.g.dart';

// BookingResponse bookingResponseFromJson(String str) =>
//     BookingResponse.fromJson(json.decode(str));

// String bookingResponseToJson(BookingResponse data) =>
//     json.encode(data.toJson());

@JsonSerializable()
class BookingResponse {
  final List<ItemBooking> data;

  BookingResponse({
    required this.data,
  });

  BookingResponse copyWith({
    List<ItemBooking>? data,
  }) =>
      BookingResponse(
        data: data ?? this.data,
      );

  factory BookingResponse.fromJson(Map<String, dynamic> json) =>
      _$BookingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookingResponseToJson(this);
}

@JsonSerializable()
class ItemBooking {
  final String? id;
  final String? status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ServiceVersion> serviceVersions;
  final String bookingStatus;
  final DateTime confirmedDate;
  final DateTime bookingDate;
  final int duration;
  final String price;
  final String discountedPrice;
  final String discountAmount;
  final String notes;
  final DateTime completedAt;
  final String cancellationReason;
  final DateTime cancelledAt;

  ItemBooking({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.serviceVersions,
    required this.bookingStatus,
    required this.confirmedDate,
    required this.bookingDate,
    required this.duration,
    required this.price,
    required this.discountedPrice,
    required this.discountAmount,
    required this.notes,
    required this.completedAt,
    required this.cancellationReason,
    required this.cancelledAt,
  });

  ItemBooking copyWith({
    String? id,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<ServiceVersion>? serviceVersions,
    String? bookingStatus,
    DateTime? confirmedDate,
    DateTime? bookingDate,
    int? duration,
    String? price,
    String? discountedPrice,
    String? discountAmount,
    String? notes,
    DateTime? completedAt,
    String? cancellationReason,
    DateTime? cancelledAt,
  }) =>
      ItemBooking(
        id: id ?? this.id,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        serviceVersions: serviceVersions ?? this.serviceVersions,
        bookingStatus: bookingStatus ?? this.bookingStatus,
        confirmedDate: confirmedDate ?? this.confirmedDate,
        bookingDate: bookingDate ?? this.bookingDate,
        duration: duration ?? this.duration,
        price: price ?? this.price,
        discountedPrice: discountedPrice ?? this.discountedPrice,
        discountAmount: discountAmount ?? this.discountAmount,
        notes: notes ?? this.notes,
        completedAt: completedAt ?? this.completedAt,
        cancellationReason: cancellationReason ?? this.cancellationReason,
        cancelledAt: cancelledAt ?? this.cancelledAt,
      );

  factory ItemBooking.fromJson(Map<String, dynamic> json) =>
      _$ItemBookingFromJson(json);

  Map<String, dynamic> toJson() => _$ItemBookingToJson(this);
}
