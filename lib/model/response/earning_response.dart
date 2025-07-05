// To parse this JSON data, do
//
//     final earningResponse = earningResponseFromJson(jsonString);

import 'package:salon_provider/config.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
part 'earning_response.g.dart';

@JsonSerializable()
class ProviderEarningResponse {
  @JsonKey(name: 'total_earnings')
  final String? totalEarnings;
  @JsonKey(name: 'completed_bookings')
  final int? completedBookings;
  @JsonKey(name: 'pending_bookings')
  final int? pendingBookings;
  @JsonKey(name: 'in_progress_bookings')
  final int? inProgressBookings;
  @JsonKey(name: 'cancelled_bookings')
  final int? cancelledBookings;
  @JsonKey(name: 'confirmed_bookings')
  final int? confirmedBookings;
  @JsonKey(name: 'total_hours')
  final double? totalHours;
  @JsonKey(name: 'total_platform_fee')
  final String? totalPlatformFee;
  @JsonKey(name: 'paid_platform_fee')
  final String? paidPlatformFee;
  @JsonKey(name: 'unpaid_platform_fee')
  final String? unpaidPlatformFee;
  @JsonKey(name: 'period')
  final String? period;
  @JsonKey(name: 'monthly_breakdown')
  final List<MonthlyEarning>? monthlyBreakdown;

  @JsonKey(name: 'withdrawable_amount')
  final String? withdrawableAmount;
  @JsonKey(name: 'total_withdrawals')
  final String? totalWithdrawals;
  @JsonKey(name: 'currency')
  final String? currency;

  ProviderEarningResponse({
    this.totalEarnings,
    this.completedBookings,
    this.pendingBookings,
    this.inProgressBookings,
    this.cancelledBookings,
    this.confirmedBookings,
    this.totalHours,
    this.totalPlatformFee,
    this.period,
    this.monthlyBreakdown,
    this.withdrawableAmount,
    this.totalWithdrawals,
    this.currency,
    this.paidPlatformFee,
    this.unpaidPlatformFee,
  });

  ProviderEarningResponse copyWith({
    String? totalEarnings,
    int? completedBookings,
    int? pendingBookings,
    int? inProgressBookings,
    int? cancelledBookings,
    int? confirmedBookings,
    double? totalHours,
    String? totalCommission,
    String? period,
    String? withdrawableAmount,
    String? totalWithdrawals,
    String? currency,
    List<MonthlyEarning>? monthlyBreakdown,
  }) =>
      ProviderEarningResponse(
        totalEarnings: totalEarnings ?? this.totalEarnings,
        completedBookings: completedBookings ?? this.completedBookings,
        pendingBookings: pendingBookings ?? this.pendingBookings,
        inProgressBookings: inProgressBookings ?? this.inProgressBookings,
        cancelledBookings: cancelledBookings ?? this.cancelledBookings,
        confirmedBookings: confirmedBookings ?? this.confirmedBookings,
        totalHours: totalHours ?? this.totalHours,
        totalPlatformFee: totalCommission ?? this.totalPlatformFee,
        period: period ?? this.period,
        withdrawableAmount: withdrawableAmount ?? this.withdrawableAmount,
        totalWithdrawals: totalWithdrawals ?? this.totalWithdrawals,
        currency: currency ?? this.currency,
        monthlyBreakdown: monthlyBreakdown ?? this.monthlyBreakdown,
        paidPlatformFee: paidPlatformFee ?? this.paidPlatformFee,
        unpaidPlatformFee: unpaidPlatformFee ?? this.unpaidPlatformFee,
      );

  getTotalEarnings() {
    return totalEarnings?.toCurrencyVnd();
  }

  getTotalCommission() {
    return totalPlatformFee?.toCurrencyVnd();
  }

  getWithdrawableAmount() {
    return withdrawableAmount?.toCurrencyVnd();
  }

  factory ProviderEarningResponse.fromJson(Map<String, dynamic> json) =>
      _$ProviderEarningResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProviderEarningResponseToJson(this);
}

@JsonSerializable()
class MonthlyEarning {
  @JsonKey(name: 'month')
  final String? month;
  @JsonKey(name: 'earnings')
  final String? earnings;
  @JsonKey(name: 'completed_bookings')
  final int? completedBookings;
  @JsonKey(name: 'pending_bookings')
  final int? pendingBookings;
  @JsonKey(name: 'cancelled_bookings')
  final int? cancelledBookings;
  @JsonKey(name: 'confirmed_bookings')
  final int? confirmedBookings;
  @JsonKey(name: 'hours')
  final int? hours;
  @JsonKey(name: 'commission')
  final String? commission;

  MonthlyEarning({
    required this.month,
    required this.earnings,
    required this.completedBookings,
    required this.pendingBookings,
    required this.cancelledBookings,
    required this.confirmedBookings,
    required this.hours,
    required this.commission,
  });

  MonthlyEarning copyWith({
    String? month,
    String? earnings,
    int? completedBookings,
    int? pendingBookings,
    int? cancelledBookings,
    int? confirmedBookings,
    int? hours,
    String? commission,
  }) =>
      MonthlyEarning(
        month: month ?? this.month,
        earnings: earnings ?? this.earnings,
        completedBookings: completedBookings ?? this.completedBookings,
        pendingBookings: pendingBookings ?? this.pendingBookings,
        cancelledBookings: cancelledBookings ?? this.cancelledBookings,
        confirmedBookings: confirmedBookings ?? this.confirmedBookings,
        hours: hours ?? this.hours,
        commission: commission ?? this.commission,
      );

  getEarnings() {
    return earnings?.toCurrencyVnd();
  }

  getCommission() {
    return commission?.toCurrencyVnd();
  }

  factory MonthlyEarning.fromJson(Map<String, dynamic> json) =>
      _$MonthlyEarningFromJson(json);

  Map<String, dynamic> toJson() => _$MonthlyEarningToJson(this);
}
