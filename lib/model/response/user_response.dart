import 'package:json_annotation/json_annotation.dart';
import 'base_response.dart';
import 'role_response.dart';
import 'user_profile_response.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse extends CommonResponse {
  @JsonKey(name: 'firstname')
  final String? firstname;
  @JsonKey(name: 'lastname')
  final String? lastname;
  @JsonKey(name: 'roles')
  final List<RoleResponse>? roles;
  @JsonKey(name: 'email')
  final String? email;
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
    this.userProfile,
    this.phoneNumber,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
