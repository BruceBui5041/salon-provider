// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_qr_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenerateQRReq _$GenerateQRReqFromJson(Map<String, dynamic> json) =>
    GenerateQRReq(
      paymentId: json['payment_id'] as String,
      bankAccountId: json['bank_account_id'] as String,
      format: json['format'] as String?,
      template: json['template'] as String?,
    );

Map<String, dynamic> _$GenerateQRReqToJson(GenerateQRReq instance) =>
    <String, dynamic>{
      'payment_id': instance.paymentId,
      'bank_account_id': instance.bankAccountId,
      'format': instance.format,
      'template': instance.template,
    };
