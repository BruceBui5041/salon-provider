// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_qr_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentQr _$PaymentQrFromJson(Map<String, dynamic> json) => PaymentQr(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      paymentId: (json['payment_id'] as num).toInt(),
      acqId: (json['acq_id'] as num).toInt(),
      accountName: json['account_name'] as String,
      accountNumber: json['account_number'] as String,
      qrCode: json['qr_code'] as String,
      qrDataUrl: json['qr_data_url'] as String,
      amount: (json['amount'] as num).toInt(),
      currency: json['currency'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$PaymentQrToJson(PaymentQr instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'payment_id': instance.paymentId,
      'acq_id': instance.acqId,
      'account_name': instance.accountName,
      'account_number': instance.accountNumber,
      'qr_code': instance.qrCode,
      'qr_data_url': instance.qrDataUrl,
      'amount': instance.amount,
      'currency': instance.currency,
      'status': instance.status,
    };
