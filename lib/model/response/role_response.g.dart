// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoleResponse _$RoleResponseFromJson(Map<String, dynamic> json) => RoleResponse(
      id: json['id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      status: json['status'] as String?,
      code: $enumDecode(_$UserRoleCodeEnumMap, json['code']),
      name: json['name'] as String,
      userCount: (json['user_count'] as num?)?.toInt(),
      commission: json['commission'] == null
          ? null
          : Commission.fromJson(json['commission'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RoleResponseToJson(RoleResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'status': instance.status,
      'code': _$UserRoleCodeEnumMap[instance.code]!,
      'name': instance.name,
      'user_count': instance.userCount,
      'commission': instance.commission,
    };

const _$UserRoleCodeEnumMap = {
  UserRoleCode.user: 'USER',
  UserRoleCode.admin: 'ADMIN',
  UserRoleCode.superAdmin: 'SUPER_ADMIN',
  UserRoleCode.provider: 'PROVIDER',
  UserRoleCode.groupProvider: 'GROUP_PROVIDER',
};
