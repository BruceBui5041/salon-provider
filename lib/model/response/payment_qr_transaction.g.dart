// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_qr_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentTransactionResponse _$PaymentTransactionResponseFromJson(
        Map<String, dynamic> json) =>
    PaymentTransactionResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              ItemPaymentQrTransaction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaymentTransactionResponseToJson(
        PaymentTransactionResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

ItemPaymentQrTransaction _$ItemPaymentQrTransactionFromJson(
        Map<String, dynamic> json) =>
    ItemPaymentQrTransaction(
      id: json['id'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      userId: (json['user_id'] as num?)?.toInt(),
      amount: (json['amount'] as num?)?.toInt(),
      currency: json['currency'] as String?,
      paymentMethod: json['payment_method'] as String?,
      transactionId: json['transaction_id'] as String?,
      transactionStatus: json['transaction_status'] as String?,
      paymentQr: json['payment_qr'] == null
          ? null
          : PaymentTracsactionQr.fromJson(
              json['payment_qr'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemPaymentQrTransactionToJson(
        ItemPaymentQrTransaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'user_id': instance.userId,
      'amount': instance.amount,
      'currency': instance.currency,
      'payment_method': instance.paymentMethod,
      'transaction_id': instance.transactionId,
      'transaction_status': instance.transactionStatus,
      'payment_qr': instance.paymentQr,
    };

PaymentTracsactionQr _$PaymentTracsactionQrFromJson(
        Map<String, dynamic> json) =>
    PaymentTracsactionQr(
      id: json['id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      paymentId: (json['payment_id'] as num?)?.toInt(),
      acqId: (json['acq_id'] as num?)?.toInt(),
      accountName: json['account_name'] as String?,
      accountNumber: json['account_number'] as String?,
      qrCode: json['qr_code'] as String?,
      qrDataUrl: json['qr_data_url'] as String?,
      amount: (json['amount'] as num?)?.toInt(),
      currency: json['currency'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$PaymentTracsactionQrToJson(
        PaymentTracsactionQr instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
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
