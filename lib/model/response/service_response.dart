// To parse this JSON data, do
//
//     final serviceResponse = serviceResponseFromJson(jsonString);

import 'package:salon_provider/model/response/image_response.dart';
import 'package:salon_provider/model/response/service_version_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'service_response.g.dart';

ServiceResponse serviceResponseFromJson(String str) =>
    ServiceResponse.fromJson(json.decode(str));

String serviceResponseToJson(ServiceResponse data) =>
    json.encode(data.toJson());

@JsonSerializable()
class ServiceResponse {
  final List<ItemService> data;

  ServiceResponse({
    required this.data,
  });

  ServiceResponse copyWith({
    List<ItemService>? data,
  }) =>
      ServiceResponse(
        data: data ?? this.data,
      );

  factory ServiceResponse.fromJson(Map<String, dynamic> json) =>
      ServiceResponse(
        data: List<ItemService>.from(
            json["data"].map((x) => ItemService.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

@JsonSerializable()
class ItemService {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
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
  @JsonKey(name: 'versions')
  final List<ServiceVersion>? versionsResponse;
  @JsonKey(name: "images")
  final List<ImageResponse>? imageResponse;

  ItemService({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.slug,
    required this.ratingCount,
    required this.reviewInfo,
    required this.avgRating,
    this.serviceVersion,
    this.versionsResponse,
    this.imageResponse,
  });

  ItemService copyWith({
    String? id,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? slug,
    int? ratingCount,
    dynamic reviewInfo,
    String? avgRating,
    ServiceVersion? serviceVersion,
    List<ServiceVersion>? versionsResponse,
    List<ImageResponse>? imageResponse,
  }) =>
      ItemService(
        id: id ?? this.id,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        slug: slug ?? this.slug,
        ratingCount: ratingCount ?? this.ratingCount,
        reviewInfo: reviewInfo ?? this.reviewInfo,
        avgRating: avgRating ?? this.avgRating,
        serviceVersion: serviceVersion ?? this.serviceVersion,
        versionsResponse: versionsResponse ?? this.versionsResponse,
        imageResponse: imageResponse ?? this.imageResponse,
      );

  factory ItemService.fromJson(Map<String, dynamic> json) =>
      _$ItemServiceFromJson(json);

  Map<String, dynamic> toJson() => _$ItemServiceToJson(this);
}
