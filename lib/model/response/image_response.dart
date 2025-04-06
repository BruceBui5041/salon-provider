// To parse this JSON data, do
//
//     final imageResponse = imageResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'image_response.g.dart';

ImageResponse imageResponseFromJson(String str) =>
    ImageResponse.fromJson(json.decode(str));

String imageResponseToJson(ImageResponse data) => json.encode(data.toJson());

@JsonSerializable()
class ImageResponse {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "created_at")
  final DateTime? createdAt;
  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "url")
  final String? url;

  ImageResponse({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.url,
  });

  ImageResponse copyWith({
    String? id,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? type,
    String? url,
  }) =>
      ImageResponse(
        id: id ?? this.id,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        type: type ?? this.type,
        url: url ?? this.url,
      );

  factory ImageResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ImageResponseToJson(this);
}
