// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commission_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Commission _$CommissionFromJson(Map<String, dynamic> json) => Commission(
      id: json['id'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      code: json['code'] as String?,
      publishedAt: json['published_at'] == null
          ? null
          : DateTime.parse(json['published_at'] as String),
      roleId: (json['role_id'] as num?)?.toInt(),
      percentage: (json['percentage'] as num?)?.toDouble(),
      minAmount: (json['min_amount'] as num?)?.toDouble(),
      maxAmount: (json['max_amount'] as num?)?.toDouble(),
      role: json['role'] == null
          ? null
          : RoleResponse.fromJson(json['role'] as Map<String, dynamic>),
      creator: json['creator'] == null
          ? null
          : UserResponse.fromJson(json['creator'] as Map<String, dynamic>),
      updater: json['updater'] == null
          ? null
          : UserResponse.fromJson(json['updater'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommissionToJson(Commission instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'status': instance.status,
      'code': instance.code,
      'published_at': instance.publishedAt?.toIso8601String(),
      'role_id': instance.roleId,
      'percentage': instance.percentage,
      'min_amount': instance.minAmount,
      'max_amount': instance.maxAmount,
      'role': instance.role,
      'creator': instance.creator,
      'updater': instance.updater,
    };
