import 'package:json_annotation/json_annotation.dart';
import 'package:salon_provider/model/response/base_response.dart';

part 'user_profile_response.g.dart';

@JsonSerializable()
class UserProfileResponse extends CommonResponse {
  @JsonKey(name: 'user_id')
  final String? userId;

  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  final String? occupation;
  final String? biography;
  final String? linkedin;
  final String? facebook;
  final String? twitter;
  final String? instagram;
  final String? firstname;
  final String? lastname;
  @JsonKey(name: 'profile_picture_url')
  final String? profilePictureUrl;

  UserProfileResponse({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.status,
    this.userId,
    this.phoneNumber,
    this.occupation,
    this.biography,
    this.linkedin,
    this.facebook,
    this.twitter,
    this.instagram,
    this.firstname,
    this.lastname,
    this.profilePictureUrl,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UserProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileResponseToJson(this);
}
