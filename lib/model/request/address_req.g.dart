// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChooseCurrentAddressReq _$ChooseCurrentAddressReqFromJson(
        Map<String, dynamic> json) =>
    ChooseCurrentAddressReq(
      addressId: json['address_id'] as String?,
      latitude: json['lat'] as String?,
      longitude: json['lng'] as String?,
      text: json['address'] as String?,
    );

Map<String, dynamic> _$ChooseCurrentAddressReqToJson(
        ChooseCurrentAddressReq instance) =>
    <String, dynamic>{
      'address_id': instance.addressId,
      'lat': instance.latitude,
      'lng': instance.longitude,
      'address': instance.text,
    };
