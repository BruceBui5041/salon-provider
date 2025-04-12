// To parse this JSON data, do
//
//     final bookingResponse = bookingResponseFromJson(jsonString);

import 'package:salon_provider/common/booking_status.dart';
import 'package:salon_provider/config.dart';
import 'package:salon_provider/model/response/base_response.dart';
import 'package:salon_provider/model/response/commission_response.dart';
import 'package:salon_provider/model/response/coupon_response.dart';
import 'package:salon_provider/model/response/payment_response.dart';
import 'package:salon_provider/model/response/service_version_response.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:salon_provider/model/response/user_response.dart';
part 'booking_response.g.dart';

@JsonSerializable()
class Booking extends CommonResponse {
  @JsonKey(name: 'service_versions')
  final List<ServiceVersion>? serviceVersions;

  @JsonKey(name: 'booking_status')
  final BookingStatus? bookingStatus;

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
  final UserResponse? serviceMan;

  @JsonKey(name: 'user')
  final UserResponse? user;

  @JsonKey(name: 'coupon')
  final Coupon? coupon;

  @JsonKey(name: 'commission')
  final Commission? commission;

  bool? isPopToHome;

  Booking({
    super.id,
    super.status,
    super.createdAt,
    super.updatedAt,
    this.serviceVersions,
    this.bookingStatus,
    this.confirmedDate,
    this.bookingDate,
    this.duration,
    this.price,
    this.discountedPrice,
    this.discountAmount,
    this.notes,
    this.completedAt,
    this.cancellationReason,
    this.cancelledAt,
    this.payment,
    this.serviceMan,
    this.user,
    this.coupon,
    this.commission,
    this.isPopToHome = false,
  });

  Booking copyWith({
    String? id,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<ServiceVersion>? serviceVersions,
    BookingStatus? bookingStatus,
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
    UserResponse? serviceMan,
    UserResponse? user,
    Coupon? coupon,
    Commission? commission,
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
        user: user ?? this.user,
        coupon: coupon ?? this.coupon,
        commission: commission ?? this.commission,
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
    return bookingStatus?.value.toLowerCase();
  }

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);

  Map<String, dynamic> toJson() => _$BookingToJson(this);
}
