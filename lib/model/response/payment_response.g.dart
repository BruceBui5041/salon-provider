// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      id: json['id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      status: json['status'] as String?,
      userId: (json['user_id'] as num?)?.toInt(),
      amount: (json['amount'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      paymentMethod: json['payment_method'] as String?,
      transactionId: json['transaction_id'] as String?,
      transactionStatus: json['transaction_status'] as String?,
      paymentQr: json['payment_qr'] == null
          ? null
          : PaymentQr.fromJson(json['payment_qr'] as Map<String, dynamic>),
      booking: json['booking'] == null
          ? null
          : ItemBooking.fromJson(json['booking'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : UserResponse.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'status': instance.status,
      'user_id': instance.userId,
      'amount': instance.amount,
      'currency': instance.currency,
      'payment_method': instance.paymentMethod,
      'transaction_id': instance.transactionId,
      'transaction_status': instance.transactionStatus,
      'payment_qr': instance.paymentQr,
      'booking': instance.booking,
      'user': instance.user,
    };
