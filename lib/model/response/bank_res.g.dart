// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bank _$BankFromJson(Map<String, dynamic> json) => Bank(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      code: json['code'] as String?,
      bin: json['bin'] as String?,
      shortName: json['short_name'] as String?,
      logo: json['logo'] as String?,
    );

Map<String, dynamic> _$BankToJson(Bank instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'bin': instance.bin,
      'short_name': instance.shortName,
      'logo': instance.logo,
    };
