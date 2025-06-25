import 'package:json_annotation/json_annotation.dart';
import 'package:salon_provider/model/response/base_response.dart';
import 'package:salon_provider/model/response/user_response.dart';

part 'address_res.g.dart';

@JsonSerializable()
class Address extends CommonResponse {
  @JsonKey(name: 'type')
  final String? type;

  @JsonKey(name: 'default')
  final bool? isDefault;

  @JsonKey(name: 'text')
  final String? text;

  @JsonKey(name: 'latitude')
  final double? latitude;

  @JsonKey(name: 'longitude')
  final double? longitude;

  @JsonKey(name: 'user')
  final UserResponse? user;

  Address({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.status,
    this.type,
    this.isDefault,
    this.text,
    this.latitude,
    this.longitude,
    this.user,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
