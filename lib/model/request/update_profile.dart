// To parse this JSON data, do
//
//     final updateProfileRequest = updateProfileRequestFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

part 'update_profile.g.dart';

UpdateProfileRequestModel updateProfileRequestFromJson(String str) =>
    UpdateProfileRequestModel.fromJson(json.decode(str));

String updateProfileRequestToJson(UpdateProfileRequestModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class UpdateProfileRequestModel {
  @JsonKey(name: "firstname")
  final String? firstname;
  @JsonKey(name: "lastname")
  final String? lastname;
  @JsonKey(name: "phone_number")
  final String? phoneNumber;
  @JsonKey(name: "occupation")
  final String? occupation;
  @JsonKey(name: "biography")
  final String? biography;
  @JsonKey(name: "linkedin")
  final String? linkedin;
  @JsonKey(name: "facebook")
  final String? facebook;
  @JsonKey(name: "twitter")
  final String? twitter;
  @JsonKey(name: "instagram")
  final String? instagram;
  @JsonKey(
    name: "profile_picture",
    toJson: _profilePictureToJson,
    fromJson: _profilePictureFromJson,
  )
  final MultipartFile? profilePicture;
  @JsonKey(name: "role_ids")
  final List<String>? roleIds;

  UpdateProfileRequestModel({
    this.firstname,
    this.lastname,
    this.phoneNumber,
    this.occupation,
    this.biography,
    this.linkedin,
    this.facebook,
    this.twitter,
    this.instagram,
    this.profilePicture,
    this.roleIds,
  });

  UpdateProfileRequestModel copyWith({
    String? firstname,
    String? lastname,
    String? phoneNumber,
    String? occupation,
    String? biography,
    String? linkedin,
    String? facebook,
    String? twitter,
    String? instagram,
    MultipartFile? profilePicture,
    List<String>? roleIds,
  }) =>
      UpdateProfileRequestModel(
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        occupation: occupation ?? this.occupation,
        biography: biography ?? this.biography,
        linkedin: linkedin ?? this.linkedin,
        facebook: facebook ?? this.facebook,
        twitter: twitter ?? this.twitter,
        instagram: instagram ?? this.instagram,
        profilePicture: profilePicture ?? this.profilePicture,
        roleIds: roleIds ?? this.roleIds,
      );

  factory UpdateProfileRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileRequestModelToJson(this);

  static MultipartFile? _profilePictureFromJson(dynamic value) => null;

  static dynamic _profilePictureToJson(MultipartFile? file) => file;
}
