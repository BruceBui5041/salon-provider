// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
part 'login_response.g.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

@JsonSerializable()
class LoginResponse {
  final LoginItem data;

  LoginResponse({
    required this.data,
  });

  LoginResponse copyWith({
    LoginItem? data,
  }) =>
      LoginResponse(
        data: data ?? this.data,
      );

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class LoginItem {
  final Token token;
  final User user;
  final String challenge;

  LoginItem({
    required this.token,
    required this.user,
    required this.challenge,
  });

  LoginItem copyWith({
    Token? token,
    User? user,
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

class User {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;
  final String lastname;
  final String firstname;
  final String email;
  final String profilePictureUrl;
  final List<Role> roles;

  User({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.lastname,
    required this.firstname,
    required this.email,
    required this.profilePictureUrl,
    required this.roles,
  });

  User copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? status,
    String? lastname,
    String? firstname,
    String? email,
    String? profilePictureUrl,
    List<Role>? roles,
  }) =>
      User(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        status: status ?? this.status,
        lastname: lastname ?? this.lastname,
        firstname: firstname ?? this.firstname,
        email: email ?? this.email,
        profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
        roles: roles ?? this.roles,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
        lastname: json["lastname"],
        firstname: json["firstname"],
        email: json["email"],
        profilePictureUrl: json["profile_picture_url"],
        roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "status": status,
        "lastname": lastname,
        "firstname": firstname,
        "email": email,
        "profile_picture_url": profilePictureUrl,
        "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
      };
}

class Role {
  final String id;
  final String status;
  final String name;
  final String description;

  Role({
    required this.id,
    required this.status,
    required this.name,
    required this.description,
  });

  Role copyWith({
    String? id,
    String? status,
    String? name,
    String? description,
  }) =>
      Role(
        id: id ?? this.id,
        status: status ?? this.status,
        name: name ?? this.name,
        description: description ?? this.description,
      );

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        status: json["status"],
        name: json["name"],
        description: json["Description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "name": name,
        "Description": description,
      };
}
