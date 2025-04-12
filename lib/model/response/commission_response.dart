// To parse this JSON data, do
//
//     final commissionResponse = commissionResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:salon_provider/model/response/base_response.dart';
import 'package:salon_provider/model/response/role_response.dart';
import 'package:salon_provider/model/response/user_response.dart';

part 'commission_response.g.dart';

@JsonSerializable()
class Commission extends CommonResponse {
  @JsonKey(name: "code")
  final String? code;

  @JsonKey(name: "published_at")
  final DateTime? publishedAt;

  @JsonKey(name: "role_id")
  final int? roleId;

  @JsonKey(name: "percentage")
  final double? percentage;

  @JsonKey(name: "min_amount")
  final double? minAmount;

  @JsonKey(name: "max_amount")
  final double? maxAmount;

  @JsonKey(name: "role")
  final RoleResponse? role;

  @JsonKey(name: "creator")
  final UserResponse? creator;

  @JsonKey(name: "updater")
  final UserResponse? updater;

  Commission({
    super.id,
    super.status,
    super.createdAt,
    super.updatedAt,
    this.code,
    this.publishedAt,
    this.roleId,
    this.percentage,
    this.minAmount,
    this.maxAmount,
    this.role,
    this.creator,
    this.updater,
  });

  Commission copyWith({
    String? id,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? code,
    DateTime? publishedAt,
    int? roleId,
    double? percentage,
    double? minAmount,
    double? maxAmount,
    RoleResponse? role,
    UserResponse? creator,
    UserResponse? updater,
  }) =>
      Commission(
        id: id ?? this.id,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        code: code ?? this.code,
        publishedAt: publishedAt ?? this.publishedAt,
        roleId: roleId ?? this.roleId,
        percentage: percentage ?? this.percentage,
        minAmount: minAmount ?? this.minAmount,
        maxAmount: maxAmount ?? this.maxAmount,
        role: role ?? this.role,
        creator: creator ?? this.creator,
        updater: updater ?? this.updater,
      );

  factory Commission.fromJson(Map<String, dynamic> json) =>
      _$CommissionFromJson(json);

  Map<String, dynamic> toJson() => _$CommissionToJson(this);
}
