import 'package:json_annotation/json_annotation.dart';
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
class ServiceVersion {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
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

  ServiceVersion({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.price,
    required this.discountedPrice,
    required this.duration,
    required this.publishedDate,
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
      );

  factory ServiceVersion.fromJson(Map<String, dynamic> json) =>
      _$ServiceVersionFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceVersionToJson(this);
}
