// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginItem _$LoginItemFromJson(Map<String, dynamic> json) => LoginItem(
      token: Token.fromJson(json['token'] as Map<String, dynamic>),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      challenge: json['challenge'] as String,
    );

Map<String, dynamic> _$LoginItemToJson(LoginItem instance) => <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
      'challenge': instance.challenge,
    };
