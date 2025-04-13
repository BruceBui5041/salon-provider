// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_version_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceVersion _$ServiceVersionFromJson(Map<String, dynamic> json) =>
    ServiceVersion(
      id: json['id'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      title: json['title'] as String?,
      description: json['description'] as String?,
      thumbnail: json['thumbnail'] as String?,
      price: json['price'] as String?,
      discountedPrice: json['discounted_price'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
      publishedDate: json['published_date'] == null
          ? null
          : DateTime.parse(json['published_date'] as String),
      categoryResponse: json['category'] == null
          ? null
          : CategoryItem.fromJson(json['category'] as Map<String, dynamic>),
      mainImageResponse: json['main_image'] == null
          ? null
          : ImageResponse.fromJson(json['main_image'] as Map<String, dynamic>),
      service: json['service'] == null
          ? null
          : ItemService.fromJson(json['service'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ImageResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServiceVersionToJson(ServiceVersion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'title': instance.title,
      'description': instance.description,
      'thumbnail': instance.thumbnail,
      'price': instance.price,
      'discounted_price': instance.discountedPrice,
      'duration': instance.duration,
      'published_date': instance.publishedDate?.toIso8601String(),
      'category': instance.categoryResponse,
      'main_image': instance.mainImageResponse,
      'service': instance.service,
      'images': instance.images,
    };
