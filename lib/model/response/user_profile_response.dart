import 'package:json_annotation/json_annotation.dart';

part 'user_profile_response.g.dart';

@JsonSerializable()
class UserProfileResponse {
  final String? id;

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

  UserProfileResponse({
    this.id,
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
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UserProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileResponseToJson(this);
}
