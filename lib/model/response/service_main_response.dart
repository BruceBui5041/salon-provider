import 'package:json_annotation/json_annotation.dart';
part 'service_main_response.g.dart';

@JsonSerializable()
class ServiceManResponse {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "created_at")
  final DateTime? createdAt;
  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;
  @JsonKey(name: "lastname")
  final String? lastname;
  @JsonKey(name: "firstname")
  final String? firstname;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "phone_number")
  final String? phoneNumber;

  ServiceManResponse({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.lastname,
    required this.firstname,
    required this.email,
    required this.phoneNumber,
  });

  ServiceManResponse copyWith({
    String? id,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? lastname,
    String? firstname,
    String? email,
    String? phoneNumber,
  }) =>
      ServiceManResponse(
        id: id ?? this.id,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        lastname: lastname ?? this.lastname,
        firstname: firstname ?? this.firstname,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
      );

  factory ServiceManResponse.fromJson(Map<String, dynamic> json) =>
      _$ServiceManResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceManResponseToJson(this);
}
