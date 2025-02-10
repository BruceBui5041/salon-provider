// To parse this JSON data, do
//
//     final createServiceRequestModel = createServiceRequestModelFromJson(jsonString);

import 'dart:convert';

CreateServiceRequestModel createServiceRequestModelFromJson(String str) =>
    CreateServiceRequestModel.fromJson(json.decode(str));

String createServiceRequestModelToJson(CreateServiceRequestModel data) =>
    json.encode(data.toJson());

class CreateServiceRequestModel {
  final String slug;
  final ServiceVersion serviceVersion;

  CreateServiceRequestModel({
    required this.slug,
    required this.serviceVersion,
  });

  CreateServiceRequestModel copyWith({
    String? slug,
    ServiceVersion? serviceVersion,
  }) =>
      CreateServiceRequestModel(
        slug: slug ?? this.slug,
        serviceVersion: serviceVersion ?? this.serviceVersion,
      );

  factory CreateServiceRequestModel.fromJson(Map<String, dynamic> json) =>
      CreateServiceRequestModel(
        slug: json["slug"],
        serviceVersion: ServiceVersion.fromJson(json["service_version"]),
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "service_version": serviceVersion.toJson(),
      };
}

class ServiceVersion {
  final String title;
  final String description;
  final String categoryId;
  final String subCategoryId;
  final String introVideoId;
  final String thumbnail;
  final String price;
  final String discountedPrice;
  final List<String> images;
  final int duration;
  final String mainImageId;

  ServiceVersion({
    required this.title,
    required this.description,
    required this.categoryId,
    required this.subCategoryId,
    required this.introVideoId,
    required this.thumbnail,
    required this.price,
    required this.discountedPrice,
    required this.images,
    required this.duration,
    required this.mainImageId,
  });

  ServiceVersion copyWith({
    String? title,
    String? description,
    String? categoryId,
    String? subCategoryId,
    String? introVideoId,
    String? thumbnail,
    String? price,
    String? discountedPrice,
    List<String>? images,
    int? duration,
    String? mainImageId,
  }) =>
      ServiceVersion(
        title: title ?? this.title,
        description: description ?? this.description,
        categoryId: categoryId ?? this.categoryId,
        subCategoryId: subCategoryId ?? this.subCategoryId,
        introVideoId: introVideoId ?? this.introVideoId,
        thumbnail: thumbnail ?? this.thumbnail,
        price: price ?? this.price,
        discountedPrice: discountedPrice ?? this.discountedPrice,
        images: images ?? this.images,
        duration: duration ?? this.duration,
        mainImageId: mainImageId ?? this.mainImageId,
      );

  factory ServiceVersion.fromJson(Map<String, dynamic> json) => ServiceVersion(
        title: json["title"],
        description: json["description"],
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
        introVideoId: json["intro_video_id?"],
        thumbnail: json["thumbnail"],
        price: json["price"],
        discountedPrice: json["discounted_price"],
        images: List<String>.from(json["images"].map((x) => x)),
        duration: json["duration"],
        mainImageId: json["main_image_id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "intro_video_id?": introVideoId,
        "thumbnail": thumbnail,
        "price": price,
        "discounted_price": discountedPrice,
        "images": List<dynamic>.from(images.map((x) => x)),
        "duration": duration,
        "main_image_id": mainImageId,
      };
}
