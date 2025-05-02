// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Service _$ServiceFromJson(Map<String, dynamic> json) => Service(
      id: json['id'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      slug: json['slug'] as String?,
      ratingCount: (json['rating_count'] as num?)?.toInt(),
      reviewInfo: json['review_info'],
      avgRating: json['avg_rating'] as String?,
      serviceVersion: json['service_version'] == null
          ? null
          : ServiceVersion.fromJson(
              json['service_version'] as Map<String, dynamic>),
      versionsResponse: (json['versions'] as List<dynamic>?)
          ?.map((e) => ServiceVersion.fromJson(e as Map<String, dynamic>))
          .toList(),
      imageResponse: (json['images'] as List<dynamic>?)
          ?.map((e) => ImageResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'status': instance.status,
      'slug': instance.slug,
      'rating_count': instance.ratingCount,
      'review_info': instance.reviewInfo,
      'avg_rating': instance.avgRating,
      'service_version': instance.serviceVersion,
      'versions': instance.versionsResponse,
      'images': instance.imageResponse,
    };
