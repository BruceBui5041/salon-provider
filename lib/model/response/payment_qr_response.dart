// To parse this JSON data, do
//
//     final genQrCodeResponse = genQrCodeResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'payment_qr_response.g.dart';

@JsonSerializable()
class PaymentQr {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "created_at")
  final DateTime createdAt;
  @JsonKey(name: "updated_at")
  final DateTime updatedAt;
  @JsonKey(name: "payment_id")
  final int paymentId;
  @JsonKey(name: "acq_id")
  final int acqId;
  @JsonKey(name: "account_name")
  final String accountName;
  @JsonKey(name: "account_number")
  final String accountNumber;
  @JsonKey(name: "qr_code")
  final String qrCode;
  @JsonKey(name: "qr_data_url")
  final String qrDataUrl;
  @JsonKey(name: "amount")
  final int amount;
  @JsonKey(name: "currency")
  final String currency;
  @JsonKey(name: "status")
  final String status;

  PaymentQr({
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

  PaymentQr copyWith({
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
      PaymentQr(
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

  factory PaymentQr.fromJson(Map<String, dynamic> json) =>
      _$PaymentQrFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentQrToJson(this);
}
