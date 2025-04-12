// To parse this JSON data, do
//
//     final couponResponse = couponResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:salon_provider/model/response/base_response.dart';

part 'coupon_response.g.dart';

@JsonSerializable()
class Coupon extends CommonResponse {
  @JsonKey(name: "code")
  final String? code;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "discount_type")
  final String? discountType;
  @JsonKey(name: "discount_value")
  final String? discountValue;
  @JsonKey(name: "min_spend")
  final String? minSpend;
  @JsonKey(name: "max_discount")
  final String? maxDiscount;
  @JsonKey(name: "start_date")
  final DateTime? startDate;
  @JsonKey(name: "end_date")
  final DateTime? endDate;
  @JsonKey(name: "usage_limit")
  final int? usageLimit;
  @JsonKey(name: "usage_count")
  final int? usageCount;

  Coupon({
    super.id,
    super.status,
    super.createdAt,
    super.updatedAt,
    this.code,
    this.description,
    this.discountType,
    this.discountValue,
    this.minSpend,
    this.maxDiscount,
    this.startDate,
    this.endDate,
    this.usageLimit,
    this.usageCount,
  });

  Coupon copyWith({
    String? id,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? code,
    String? description,
    String? discountType,
    String? discountValue,
    String? minSpend,
    String? maxDiscount,
    DateTime? startDate,
    DateTime? endDate,
    int? usageLimit,
    int? usageCount,
  }) =>
      Coupon(
        id: id ?? this.id,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        code: code ?? this.code,
        description: description ?? this.description,
        discountType: discountType ?? this.discountType,
        discountValue: discountValue ?? this.discountValue,
        minSpend: minSpend ?? this.minSpend,
        maxDiscount: maxDiscount ?? this.maxDiscount,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        usageLimit: usageLimit ?? this.usageLimit,
        usageCount: usageCount ?? this.usageCount,
      );

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);

  Map<String, dynamic> toJson() => _$CouponToJson(this);
}
