// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:salon_provider/model/response/role_response.dart';
import 'package:salon_provider/model/response/user_response.dart';
part 'login_response.g.dart';

@JsonSerializable()
class LoginItem {
  final Token token;
  final UserResponse user;
  final String challenge;

  LoginItem({
    required this.token,
    required this.user,
    required this.challenge,
  });

  LoginItem copyWith({
    Token? token,
    UserResponse? user,
    String? challenge,
  }) =>
      LoginItem(
        token: token ?? this.token,
        user: user ?? this.user,
        challenge: challenge ?? this.challenge,
      );

  factory LoginItem.fromJson(Map<String, dynamic> json) =>
      _$LoginItemFromJson(json);

  Map<String, dynamic> toJson() => _$LoginItemToJson(this);
}

class Token {
  final String token;
  final DateTime created;
  final int expiry;

  Token({
    required this.token,
    required this.created,
    required this.expiry,
  });

  Token copyWith({
    String? token,
    DateTime? created,
    int? expiry,
  }) =>
      Token(
        token: token ?? this.token,
        created: created ?? this.created,
        expiry: expiry ?? this.expiry,
      );

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        token: json["token"],
        created: DateTime.parse(json["created"]),
        expiry: json["expiry"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "created": created.toIso8601String(),
        "expiry": expiry,
      };
}
