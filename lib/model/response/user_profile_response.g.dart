// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileResponse _$UserProfileResponseFromJson(Map<String, dynamic> json) =>
    UserProfileResponse(
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      phoneNumber: json['phone_number'] as String?,
      occupation: json['occupation'] as String?,
      biography: json['biography'] as String?,
      linkedin: json['linkedin'] as String?,
      facebook: json['facebook'] as String?,
      twitter: json['twitter'] as String?,
      instagram: json['instagram'] as String?,
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
    );

Map<String, dynamic> _$UserProfileResponseToJson(
        UserProfileResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'phone_number': instance.phoneNumber,
      'occupation': instance.occupation,
      'biography': instance.biography,
      'linkedin': instance.linkedin,
      'facebook': instance.facebook,
      'twitter': instance.twitter,
      'instagram': instance.instagram,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
    };
