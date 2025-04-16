// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_account_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankAccountRes _$BankAccountResFromJson(Map<String, dynamic> json) =>
    BankAccountRes(
      id: json['id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      status: json['status'] as String?,
      name: json['name'] as String?,
      code: json['code'] as String?,
      bin: json['bin'] as String?,
      shortName: json['short_name'] as String?,
      logo: json['logo'] as String?,
      accountName: json['account_name'] as String?,
      accountNumber: json['account_number'] as String?,
      swiftCode: json['swift_code'] as String?,
      isDefault: json['is_default'] as bool?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$BankAccountResToJson(BankAccountRes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'status': instance.status,
      'name': instance.name,
      'code': instance.code,
      'bin': instance.bin,
      'short_name': instance.shortName,
      'logo': instance.logo,
      'account_name': instance.accountName,
      'account_number': instance.accountNumber,
      'swift_code': instance.swiftCode,
      'is_default': instance.isDefault,
      'notes': instance.notes,
    };
