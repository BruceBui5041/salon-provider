// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponResponse _$CouponResponseFromJson(Map<String, dynamic> json) =>
    CouponResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => ItemCoupon.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CouponResponseToJson(CouponResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

ItemCoupon _$ItemCouponFromJson(Map<String, dynamic> json) => ItemCoupon(
      id: json['id'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      code: json['code'] as String,
      description: json['description'] as String,
      discountType: json['discount_type'] as String,
      discountValue: json['discount_value'] as String,
      minSpend: json['min_spend'] as String,
      maxDiscount: json['max_discount'] as String,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      usageLimit: (json['usage_limit'] as num).toInt(),
      usageCount: (json['usage_count'] as num).toInt(),
    );

Map<String, dynamic> _$ItemCouponToJson(ItemCoupon instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'code': instance.code,
      'description': instance.description,
      'discount_type': instance.discountType,
      'discount_value': instance.discountValue,
      'min_spend': instance.minSpend,
      'max_discount': instance.maxDiscount,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
      'usage_limit': instance.usageLimit,
      'usage_count': instance.usageCount,
    };
