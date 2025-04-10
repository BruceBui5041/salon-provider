// To parse this JSON data, do
//
//     final bookingResponse = bookingResponseFromJson(jsonString);

import 'package:salon_provider/config.dart';
import 'package:salon_provider/model/response/base_response.dart';
import 'package:salon_provider/model/response/coupon_response.dart';
import 'package:salon_provider/model/response/payment_response.dart';
import 'package:salon_provider/model/response/service_main_response.dart';
import 'package:salon_provider/model/response/service_version_response.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
part 'booking_response.g.dart';

@JsonSerializable()
class Booking extends CommonResponse {
  @JsonKey(name: 'service_versions')
  final List<ServiceVersion>? serviceVersions;
  @JsonKey(name: 'booking_status')
  final String? bookingStatus;
  @JsonKey(name: 'confirmed_date')
  final DateTime? confirmedDate;
  @JsonKey(name: 'booking_date')
  final DateTime? bookingDate;
  @JsonKey(name: 'duration')
  final int? duration;
  @JsonKey(name: 'price')
  final String? price;
  @JsonKey(name: 'discounted_price')
  final String? discountedPrice;
  @JsonKey(name: 'discount_amount')
  final String? discountAmount;
  @JsonKey(name: 'notes')
  final String? notes;
  @JsonKey(name: 'completed_at')
  final DateTime? completedAt;
  @JsonKey(name: 'cancellation_reason')
  final String? cancellationReason;
  @JsonKey(name: 'cancelled_at')
  final DateTime? cancelledAt;
  @JsonKey(name: 'payment')
  final Payment? payment;
  @JsonKey(name: 'service_man')
  final ServiceManResponse? serviceMan;
  @JsonKey(name: 'coupon')
  final ItemCoupon? coupon;

  bool? isPopToHome;

  Booking({
    required super.id,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
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
    required this.payment,
    required this.serviceMan,
    this.coupon,
    this.isPopToHome = false,
  });

  Booking copyWith({
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
    Payment? payment,
    ServiceManResponse? serviceMan,
    ItemCoupon? coupon,
    bool? isPopToHome,
  }) =>
      Booking(
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
        payment: payment ?? this.payment,
        serviceMan: serviceMan ?? this.serviceMan,
        coupon: coupon ?? this.coupon,
        isPopToHome: isPopToHome ?? this.isPopToHome,
      );

  getDiscountedPrice() {
    return discountedPrice?.toCurrencyVnd();
  }

  getPrice() {
    return price?.toCurrencyVnd();
  }

  getDiscountAmount() {
    return discountAmount?.toCurrencyVnd();
  }

  getBookingStatus() {
    return bookingStatus?.toLowerCase();
  }

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);

  Map<String, dynamic> toJson() => _$BookingToJson(this);
}
