import 'package:salon_provider/model/response/base_response.dart';
import 'package:salon_provider/model/response/category_response.dart';
import 'package:salon_provider/model/response/image_response.dart';
import 'package:salon_provider/model/response/main_image_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:salon_provider/model/response/service_response.dart';

part 'service_version_response.g.dart';

enum ServiceVersionEnum {
  id,
  status,
  createdAt,
  updatedAt,
  title,
  description,
  thumbnail,
  price,
  discountedPrice,
  duration,
  publishedDate,
}

@JsonSerializable()
class ServiceVersion extends CommonResponse {
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'thumbnail')
  final String? thumbnail;
  @JsonKey(name: 'price')
  final String? price;
  @JsonKey(name: 'discounted_price')
  final String? discountedPrice;
  @JsonKey(name: 'duration')
  final int? duration;
  @JsonKey(name: 'published_date')
  final DateTime? publishedDate;
  @JsonKey(name: "category")
  final CategoryItem? categoryResponse;
  @JsonKey(name: "main_image")
  final ImageResponse? mainImageResponse;
  @JsonKey(name: "service")
  final Service? service;
  @JsonKey(name: "images")
  final List<ImageResponse>? images;

  ServiceVersion({
    super.id,
    super.status,
    super.createdAt,
    super.updatedAt,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.price,
    required this.discountedPrice,
    required this.duration,
    required this.publishedDate,
    this.categoryResponse,
    this.mainImageResponse,
    this.service,
    this.images,
  });

  ServiceVersion copyWith({
    String? id,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? title,
    String? description,
    String? thumbnail,
    String? price,
    String? discountedPrice,
    int? duration,
    DateTime? publishedDate,
    CategoryItem? categoryResponse,
    ImageResponse? imageResponse,
    ImageResponse? mainImageResponse,
    Service? service,
    List<ImageResponse>? images,
  }) =>
      ServiceVersion(
        id: id ?? this.id,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        title: title ?? this.title,
        description: description ?? this.description,
        thumbnail: thumbnail ?? this.thumbnail,
        price: price ?? this.price,
        discountedPrice: discountedPrice ?? this.discountedPrice,
        duration: duration ?? this.duration,
        publishedDate: publishedDate ?? this.publishedDate,
        categoryResponse: categoryResponse ?? this.categoryResponse,
        mainImageResponse: mainImageResponse ?? this.mainImageResponse,
        service: service ?? this.service,
        images: images ?? this.images,
      );

  factory ServiceVersion.fromJson(Map<String, dynamic> json) =>
      _$ServiceVersionFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceVersionToJson(this);

  bool isDraft() {
    return publishedDate == null;
  }

  String getPublishStatus() {
    if (isDraft()) {
      return "Draft";
    }
    return status ?? "";
  }
}
