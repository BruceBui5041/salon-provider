// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequestModel _$RegisterRequestModelFromJson(
        Map<String, dynamic> json) =>
    RegisterRequestModel(
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      authType: json['auth_type'] as String?,
      phoneNumber: json['phone_number'] as String?,
    );

Map<String, dynamic> _$RegisterRequestModelToJson(
        RegisterRequestModel instance) =>
    <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'auth_type': instance.authType,
      'phone_number': instance.phoneNumber,
    };
