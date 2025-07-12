// To parse this JSON data, do
//
//     final serviceResponse = serviceResponseFromJson(jsonString);

import 'package:salon_provider/model/response/base_response.dart';
import 'package:salon_provider/model/response/image_response.dart';
import 'package:salon_provider/model/response/service_version_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:salon_provider/model/response/user_response.dart';

part 'service_response.g.dart';

@JsonSerializable()
class Service extends CommonResponse {
  @JsonKey(name: 'slug')
  final String? slug;
  @JsonKey(name: 'rating_count')
  final int? ratingCount;
  @JsonKey(name: 'review_info')
  final dynamic reviewInfo;
  @JsonKey(name: 'avg_rating')
  final String? avgRating;
  @JsonKey(name: 'service_version')
  final ServiceVersion? serviceVersion;
  @JsonKey(name: 'service_version_id')
  final String? serviceVersionId;
  @JsonKey(name: 'versions')
  final List<ServiceVersion>? versionsResponse;
  @JsonKey(name: "images")
  final List<ImageResponse>? imageResponse;
  @JsonKey(name: "owner")
  final UserResponse? owner;
  @JsonKey(name: "owner_id")
  final String? ownerId;

  Service({
    super.id,
    super.status,
    super.createdAt,
    super.updatedAt,
    this.slug,
    this.ratingCount,
    this.reviewInfo,
    this.avgRating,
    this.serviceVersion,
    this.serviceVersionId,
    this.versionsResponse,
    this.imageResponse,
    this.owner,
    this.ownerId,
  });

  Service copyWith({
    String? id,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? slug,
    int? ratingCount,
    dynamic reviewInfo,
    String? avgRating,
    ServiceVersion? serviceVersion,
    String? serviceVersionId,
    List<ServiceVersion>? versionsResponse,
    List<ImageResponse>? imageResponse,
    UserResponse? owner,
    String? ownerId,
  }) =>
      Service(
        id: id ?? this.id,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        slug: slug ?? this.slug,
        ratingCount: ratingCount ?? this.ratingCount,
        reviewInfo: reviewInfo ?? this.reviewInfo,
        avgRating: avgRating ?? this.avgRating,
        serviceVersion: serviceVersion ?? this.serviceVersion,
        serviceVersionId: serviceVersionId ?? this.serviceVersionId,
        versionsResponse: versionsResponse ?? this.versionsResponse,
        imageResponse: imageResponse ?? this.imageResponse,
        owner: owner ?? this.owner,
        ownerId: ownerId ?? this.ownerId,
      );

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}
