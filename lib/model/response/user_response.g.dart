// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      id: json['id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      status: json['status'] as String?,
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      roles: (json['roles'] as List<dynamic>?)
          ?.map((e) => RoleResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      email: json['email'] as String?,
      userProfile: json['user_profile'] == null
          ? null
          : UserProfileResponse.fromJson(
              json['user_profile'] as Map<String, dynamic>),
      phoneNumber: json['phone_number'] as String?,
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'status': instance.status,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'roles': instance.roles,
      'email': instance.email,
      'user_profile': instance.userProfile,
      'phone_number': instance.phoneNumber,
    };
