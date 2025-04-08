import 'package:json_annotation/json_annotation.dart';
import 'base_response.dart';
import 'role_response.dart';
import 'user_profile_response.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse extends CommonResponse {
  final String firstname;
  final String lastname;
  final List<RoleResponse> roles;
  final String email;
  @JsonKey(name: 'profile_picture_url')
  final String? profilePictureUrl;
  @JsonKey(name: 'user_profile')
  final UserProfileResponse? userProfile;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;

  UserResponse({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.firstname,
    required this.lastname,
    required this.roles,
    required this.email,
    this.profilePictureUrl,
    this.userProfile,
    this.phoneNumber,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
