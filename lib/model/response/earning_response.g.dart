// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'earning_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProviderEarningResponse _$ProviderEarningResponseFromJson(
        Map<String, dynamic> json) =>
    ProviderEarningResponse(
      totalEarnings: json['total_earnings'] as String?,
      completedBookings: (json['completed_bookings'] as num?)?.toInt(),
      pendingBookings: (json['pending_bookings'] as num?)?.toInt(),
      inProgressBookings: (json['in_progress_bookings'] as num?)?.toInt(),
      cancelledBookings: (json['cancelled_bookings'] as num?)?.toInt(),
      confirmedBookings: (json['confirmed_bookings'] as num?)?.toInt(),
      totalHours: (json['total_hours'] as num?)?.toInt(),
      totalCommission: json['total_commission'] as String?,
      period: json['period'] as String?,
      monthlyBreakdown: (json['monthly_breakdown'] as List<dynamic>?)
          ?.map((e) => MonthlyEarning.fromJson(e as Map<String, dynamic>))
          .toList(),
      withdrawableAmount: json['withdrawable_amount'] as String?,
      totalWithdrawals: json['total_withdrawals'] as String?,
      currency: json['currency'] as String?,
    );

Map<String, dynamic> _$ProviderEarningResponseToJson(
        ProviderEarningResponse instance) =>
    <String, dynamic>{
      'total_earnings': instance.totalEarnings,
      'completed_bookings': instance.completedBookings,
      'pending_bookings': instance.pendingBookings,
      'in_progress_bookings': instance.inProgressBookings,
      'cancelled_bookings': instance.cancelledBookings,
      'confirmed_bookings': instance.confirmedBookings,
      'total_hours': instance.totalHours,
      'total_commission': instance.totalCommission,
      'period': instance.period,
      'monthly_breakdown': instance.monthlyBreakdown,
      'withdrawable_amount': instance.withdrawableAmount,
      'total_withdrawals': instance.totalWithdrawals,
      'currency': instance.currency,
    };

MonthlyEarning _$MonthlyEarningFromJson(Map<String, dynamic> json) =>
    MonthlyEarning(
      month: json['month'] as String?,
      earnings: json['earnings'] as String?,
      completedBookings: (json['completed_bookings'] as num?)?.toInt(),
      pendingBookings: (json['pending_bookings'] as num?)?.toInt(),
      cancelledBookings: (json['cancelled_bookings'] as num?)?.toInt(),
      confirmedBookings: (json['confirmed_bookings'] as num?)?.toInt(),
      hours: (json['hours'] as num?)?.toInt(),
      commission: json['commission'] as String?,
    );

Map<String, dynamic> _$MonthlyEarningToJson(MonthlyEarning instance) =>
    <String, dynamic>{
      'month': instance.month,
      'earnings': instance.earnings,
      'completed_bookings': instance.completedBookings,
      'pending_bookings': instance.pendingBookings,
      'cancelled_bookings': instance.cancelledBookings,
      'confirmed_bookings': instance.confirmedBookings,
      'hours': instance.hours,
      'commission': instance.commission,
    };
