// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_image_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainImageResponse _$MainImageResponseFromJson(Map<String, dynamic> json) =>
    MainImageResponse(
      id: json['id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      status: json['status'] as String?,
      type: json['type'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$MainImageResponseToJson(MainImageResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'status': instance.status,
      'type': instance.type,
      'url': instance.url,
    };
