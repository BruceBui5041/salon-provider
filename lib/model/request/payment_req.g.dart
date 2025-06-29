// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePaymentReq _$UpdatePaymentReqFromJson(Map<String, dynamic> json) =>
    UpdatePaymentReq(
      paymentMethod:
          $enumDecodeNullable(_$PaymentMethodEnumMap, json['payment_method']),
    );

Map<String, dynamic> _$UpdatePaymentReqToJson(UpdatePaymentReq instance) =>
    <String, dynamic>{
      'payment_method': _$PaymentMethodEnumMap[instance.paymentMethod],
    };

const _$PaymentMethodEnumMap = {
  PaymentMethod.cash: 'cash',
  PaymentMethod.transfer: 'transfer',
};
