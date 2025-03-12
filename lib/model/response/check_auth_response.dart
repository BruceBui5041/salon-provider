// To parse this JSON data, do
//
//     final checkAuthResponse = checkAuthResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CheckAuthResponse checkAuthResponseFromJson(String str) =>
    CheckAuthResponse.fromJson(json.decode(str));

String checkAuthResponseToJson(CheckAuthResponse data) =>
    json.encode(data.toJson());

class CheckAuthResponse {
  final Data data;

  CheckAuthResponse({
    required this.data,
  });

  CheckAuthResponse copyWith({
    Data? data,
  }) =>
      CheckAuthResponse(
        data: data ?? this.data,
      );

  factory CheckAuthResponse.fromJson(Map<String, dynamic> json) =>
      CheckAuthResponse(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  final String status;
  final String lastname;
  final String firstname;
  final String email;
  final String profilePictureUrl;
  final String phoneNumber;
  final List<Role> roles;
  final List<dynamic> enrollments;
  final dynamic auths;
  final String id;

  Data({
    required this.status,
    required this.lastname,
    required this.firstname,
    required this.email,
    required this.profilePictureUrl,
    required this.phoneNumber,
    required this.roles,
    required this.enrollments,
    required this.auths,
    required this.id,
  });

  Data copyWith({
    String? status,
    String? lastname,
    String? firstname,
    String? email,
    String? profilePictureUrl,
    String? phoneNumber,
    List<Role>? roles,
    List<dynamic>? enrollments,
    dynamic auths,
    String? id,
  }) =>
      Data(
        status: status ?? this.status,
        lastname: lastname ?? this.lastname,
        firstname: firstname ?? this.firstname,
        email: email ?? this.email,
        profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        roles: roles ?? this.roles,
        enrollments: enrollments ?? this.enrollments,
        auths: auths ?? this.auths,
        id: id ?? this.id,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        lastname: json["lastname"],
        firstname: json["firstname"],
        email: json["email"],
        profilePictureUrl: json["profile_picture_url"],
        phoneNumber: json["phone_number"],
        roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
        enrollments: List<dynamic>.from(json["enrollments"].map((x) => x)),
        auths: json["auths"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "lastname": lastname,
        "firstname": firstname,
        "email": email,
        "profile_picture_url": profilePictureUrl,
        "phone_number": phoneNumber,
        "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
        "enrollments": List<dynamic>.from(enrollments.map((x) => x)),
        "auths": auths,
        "id": id,
      };
}

class Role {
  final String id;
  final String status;
  final String name;
  final String code;
  final String description;

  Role({
    required this.id,
    required this.status,
    required this.name,
    required this.code,
    required this.description,
  });

  Role copyWith({
    String? id,
    String? status,
    String? name,
    String? code,
    String? description,
  }) =>
      Role(
        id: id ?? this.id,
        status: status ?? this.status,
        name: name ?? this.name,
        code: code ?? this.code,
        description: description ?? this.description,
      );

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        status: json["status"],
        name: json["name"],
        code: json["code"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "name": name,
        "code": code,
        "description": description,
      };
}
