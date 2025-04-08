// To parse this JSON data, do
//
//     final couponResponse = couponResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'coupon_response.g.dart';

CouponResponse couponResponseFromJson(String str) =>
    CouponResponse.fromJson(json.decode(str));

String couponResponseToJson(CouponResponse data) => json.encode(data.toJson());

@JsonSerializable()
class CouponResponse {
  @JsonKey(name: "data")
  final List<ItemCoupon> data;

  CouponResponse({
    required this.data,
  });

  CouponResponse copyWith({
    List<ItemCoupon>? data,
  }) =>
      CouponResponse(
        data: data ?? this.data,
      );

  factory CouponResponse.fromJson(Map<String, dynamic> json) =>
      _$CouponResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CouponResponseToJson(this);
}

@JsonSerializable()
class ItemCoupon {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "status")
  final String status;
  @JsonKey(name: "created_at")
  final DateTime createdAt;
  @JsonKey(name: "updated_at")
  final DateTime updatedAt;
  @JsonKey(name: "code")
  final String code;
  @JsonKey(name: "description")
  final String description;
  @JsonKey(name: "discount_type")
  final String discountType;
  @JsonKey(name: "discount_value")
  final String discountValue;
  @JsonKey(name: "min_spend")
  final String minSpend;
  @JsonKey(name: "max_discount")
  final String maxDiscount;
  @JsonKey(name: "start_date")
  final DateTime startDate;
  @JsonKey(name: "end_date")
  final DateTime endDate;
  @JsonKey(name: "usage_limit")
  final int usageLimit;
  @JsonKey(name: "usage_count")
  final int usageCount;

  ItemCoupon({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.code,
    required this.description,
    required this.discountType,
    required this.discountValue,
    required this.minSpend,
    required this.maxDiscount,
    required this.startDate,
    required this.endDate,
    required this.usageLimit,
    required this.usageCount,
  });

  ItemCoupon copyWith({
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
      ItemCoupon(
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

  factory ItemCoupon.fromJson(Map<String, dynamic> json) =>
      _$ItemCouponFromJson(json);

  Map<String, dynamic> toJson() => _$ItemCouponToJson(this);
}
