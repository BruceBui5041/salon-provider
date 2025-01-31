// To parse this JSON data, do
//
//     final registerRequest = registerRequestFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'register_request_model.g.dart';

RegisterRequestModel registerRequestFromJson(String str) =>
    RegisterRequestModel.fromJson(json.decode(str));

String registerRequestToJson(RegisterRequestModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class RegisterRequestModel {
  @JsonKey(name: "firstname")
  final String? firstname;
  @JsonKey(name: "lastname")
  final String? lastname;
  @JsonKey(name: "auth_type")
  final String? authType;
  @JsonKey(name: "phone_number")
  final String? phoneNumber;

  RegisterRequestModel({
    this.firstname,
    this.lastname,
    this.authType,
    this.phoneNumber,
  });

  RegisterRequestModel copyWith({
    String? firstname,
    String? lastname,
    String? authType,
    String? phoneNumber,
  }) =>
      RegisterRequestModel(
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        authType: authType ?? this.authType,
        phoneNumber: phoneNumber ?? this.phoneNumber,
      );

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestModelToJson(this);
}
