// To parse this JSON data, do
//
//     final genQrCodeResponse = genQrCodeResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:salon_provider/model/response/base_response.dart';
import 'dart:convert';

import 'package:salon_provider/model/response/payment_response.dart';

part 'payment_qr_response.g.dart';

@JsonSerializable()
class PaymentQr extends CommonResponse {
  @JsonKey(name: "payment")
  final Payment? payment;
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
  final String? currency;

  PaymentQr({
    super.id,
    super.createdAt,
    super.updatedAt,
    super.status,
    this.payment,
    this.acqId,
    this.accountName,
    this.accountNumber,
    this.qrCode,
    this.qrDataUrl,
    this.amount,
    this.currency,
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
    Payment? payment,
  }) =>
      PaymentQr(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        status: status ?? this.status,
        acqId: acqId ?? this.acqId,
        accountName: accountName ?? this.accountName,
        accountNumber: accountNumber ?? this.accountNumber,
        qrCode: qrCode ?? this.qrCode,
        qrDataUrl: qrDataUrl ?? this.qrDataUrl,
        amount: amount ?? this.amount,
        currency: currency ?? this.currency,
        payment: payment ?? this.payment,
      );

  factory PaymentQr.fromJson(Map<String, dynamic> json) =>
      _$PaymentQrFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentQrToJson(this);
}
