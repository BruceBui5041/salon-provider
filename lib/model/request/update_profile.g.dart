// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileRequestModel _$UpdateProfileRequestModelFromJson(
        Map<String, dynamic> json) =>
    UpdateProfileRequestModel(
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      phoneNumber: json['phone_number'] as String?,
      occupation: json['occupation'] as String?,
      biography: json['biography'] as String?,
      linkedin: json['linkedin'] as String?,
      facebook: json['facebook'] as String?,
      twitter: json['twitter'] as String?,
      instagram: json['instagram'] as String?,
      profilePicture: UpdateProfileRequestModel._profilePictureFromJson(
          json['profile_picture']),
      roleIds: (json['role_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UpdateProfileRequestModelToJson(
        UpdateProfileRequestModel instance) =>
    <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'phone_number': instance.phoneNumber,
      'occupation': instance.occupation,
      'biography': instance.biography,
      'linkedin': instance.linkedin,
      'facebook': instance.facebook,
      'twitter': instance.twitter,
      'instagram': instance.instagram,
      'profile_picture': UpdateProfileRequestModel._profilePictureToJson(
          instance.profilePicture),
      'role_ids': instance.roleIds,
    };

UpdateUserStatusRequest _$UpdateUserStatusRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateUserStatusRequest(
      status: json['status'] as String?,
    );

Map<String, dynamic> _$UpdateUserStatusRequestToJson(
        UpdateUserStatusRequest instance) =>
    <String, dynamic>{
      'status': instance.status,
    };
