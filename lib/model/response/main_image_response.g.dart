// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_image_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainImageResponse _$MainImageResponseFromJson(Map<String, dynamic> json) =>
    MainImageResponse(
      id: json['id'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      type: json['type'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$MainImageResponseToJson(MainImageResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'type': instance.type,
      'url': instance.url,
    };
