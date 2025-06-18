import 'package:json_annotation/json_annotation.dart';
import 'package:salon_provider/model/response/commission_response.dart';
import 'base_response.dart';

part 'role_response.g.dart';

enum UserRoleCode {
  @JsonValue('USER')
  user,
  @JsonValue('ADMIN')
  admin,
  @JsonValue('SUPER_ADMIN')
  superAdmin,
  @JsonValue('PROVIDER')
  provider,
  @JsonValue('GROUP_PROVIDER')
  groupProvider,
}

@JsonSerializable()
class RoleResponse extends CommonResponse {
  final UserRoleCode code;
  final String name;
  @JsonKey(name: 'user_count')
  final int? userCount;
  @JsonKey(name: 'commission')
  final Commission? commission;

  RoleResponse({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.status,
    required this.code,
    required this.name,
    this.userCount,
    this.commission,
  });

  factory RoleResponse.fromJson(Map<String, dynamic> json) =>
      _$RoleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RoleResponseToJson(this);
}
