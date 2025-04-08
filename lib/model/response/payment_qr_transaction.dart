// To parse this JSON data, do
//
//     final paymentTransactionResponse = paymentTransactionResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'payment_qr_transaction.g.dart';

@JsonSerializable()
class ItemPaymentQrTransaction {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "created_at")
  final DateTime? createdAt;
  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;
  @JsonKey(name: "user_id")
  final int? userId;
  @JsonKey(name: "amount")
  final int? amount;
  @JsonKey(name: "currency")
  final String? currency;
  @JsonKey(name: "payment_method")
  final String? paymentMethod;
  @JsonKey(name: "transaction_id")
  final String? transactionId;
  @JsonKey(name: "transaction_status")
  final String? transactionStatus;
  @JsonKey(name: "payment_qr")
  final PaymentTracsactionQr? paymentQr;

  ItemPaymentQrTransaction({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.amount,
    required this.currency,
    required this.paymentMethod,
    required this.transactionId,
    required this.transactionStatus,
    required this.paymentQr,
  });

  ItemPaymentQrTransaction copyWith({
    String? id,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? userId,
    int? amount,
    String? currency,
    String? paymentMethod,
    String? transactionId,
    String? transactionStatus,
    PaymentTracsactionQr? paymentQr,
  }) =>
      ItemPaymentQrTransaction(
        id: id ?? this.id,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        userId: userId ?? this.userId,
        amount: amount ?? this.amount,
        currency: currency ?? this.currency,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        transactionId: transactionId ?? this.transactionId,
        transactionStatus: transactionStatus ?? this.transactionStatus,
        paymentQr: paymentQr ?? this.paymentQr,
      );

  factory ItemPaymentQrTransaction.fromJson(Map<String, dynamic> json) =>
      _$ItemPaymentQrTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$ItemPaymentQrTransactionToJson(this);
}

@JsonSerializable()
class PaymentTracsactionQr {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "created_at")
  final DateTime? createdAt;
  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;
  @JsonKey(name: "payment_id")
  final int? paymentId;
  @JsonKey(name: "acq_id")
  final int? acqId;
  @JsonKey(name: "account_name")
  final String? accountName;
  @JsonKey(name: "account_number")
  final String? accountNumber;
  @JsonKey(name: "qr_code")
  final String? qrCode;
  @JsonKey(name: "qr_data_url")
  final String? qrDataUrl;
  @JsonKey(name: "amount")
  final int? amount;
  @JsonKey(name: "currency")
  final String currency;
  @JsonKey(name: "status")
  final String status;

  PaymentTracsactionQr({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.paymentId,
    required this.acqId,
    required this.accountName,
    required this.accountNumber,
    required this.qrCode,
    required this.qrDataUrl,
    required this.amount,
    required this.currency,
    required this.status,
  });

  PaymentTracsactionQr copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? paymentId,
    int? acqId,
    String? accountName,
    String? accountNumber,
    String? qrCode,
    String? qrDataUrl,
    int? amount,
    String? currency,
    String? status,
  }) =>
      PaymentTracsactionQr(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        paymentId: paymentId ?? this.paymentId,
        acqId: acqId ?? this.acqId,
        accountName: accountName ?? this.accountName,
        accountNumber: accountNumber ?? this.accountNumber,
        qrCode: qrCode ?? this.qrCode,
        qrDataUrl: qrDataUrl ?? this.qrDataUrl,
        amount: amount ?? this.amount,
        currency: currency ?? this.currency,
        status: status ?? this.status,
      );

  factory PaymentTracsactionQr.fromJson(Map<String, dynamic> json) =>
      _$PaymentTracsactionQrFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentTracsactionQrToJson(this);
}
