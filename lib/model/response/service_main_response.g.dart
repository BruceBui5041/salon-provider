// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_main_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceManResponse _$ServiceManResponseFromJson(Map<String, dynamic> json) =>
    ServiceManResponse(
      id: json['id'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      lastname: json['lastname'] as String?,
      firstname: json['firstname'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
    );

Map<String, dynamic> _$ServiceManResponseToJson(ServiceManResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'lastname': instance.lastname,
      'firstname': instance.firstname,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
    };
