// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:json_annotation/json_annotation.dart';
// part 'create_service_model.g.dart';

// @JsonSerializable()
// class ServiceRequest {
//   @JsonKey(name: "slug")
//   final String slug;
//   @JsonKey(name: "images")
//   final List<MultipartFile> images;

//   ServiceRequest({
//     required this.slug,
//     required this.images,
//   });

//   // ✅ Convert from JSON
//   factory ServiceRequest.fromJson(Map<String, dynamic> json) {
//     return ServiceRequest(
//       slug: json["slug"],
//       images: (json["images"] as List)
//           .map((file) => file as MultipartFile)
//           .toList(),
//     );
//   }

//   // ✅ Convert to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       "slug": slug,
//       "images": images,
//     };
//   }

//   // ✅ Clone object
//   ServiceRequest copyWith({
//     String? slug,
//     ServiceVersion? serviceVersion,
//     List<MultipartFile>? images,
//     MultipartFile? thumbnail,
//   }) {
//     return ServiceRequest(
//       slug: slug ?? this.slug,
//       images: images ?? this.images,
//     );
//   }
// }

// // ===============================
// // 📌 Class con: `ServiceVersion`
// // ===============================
// class ServiceVersion {
//   @JsonKey(name: "title")
//   final String title;
//   @JsonKey(name: "description")
//   final String description;
//   @JsonKey(name: "category_id")
//   final String categoryId;
//   @JsonKey(name: "sub_category_id")
//   final String subCategoryId;
//   @JsonKey(name: "thumbnail")
//   final MultipartFile thumbnail;
//   @JsonKey(name: "price")
//   final String price;
//   @JsonKey(name: "discounted_price")
//   final String discountedPrice;
//   @JsonKey(name: "duration")
//   final int duration;
//   @JsonKey(name: "main_image_id")
//   final int mainImageId;

//   ServiceVersion({
//     required this.title,
//     required this.description,
//     required this.categoryId,
//     required this.subCategoryId,
//     required this.thumbnail,
//     required this.price,
//     required this.discountedPrice,
//     required this.duration,
//     required this.mainImageId,
//   });

//   // ✅ Convert from JSON
//   factory ServiceVersion.fromJson(Map<String, dynamic> json) {
//     return ServiceVersion(
//       title: json["title"],
//       description: json["description"],
//       categoryId: json["category_id"],
//       subCategoryId: json["sub_category_id"],
//       thumbnail: json["thumbnail"] as MultipartFile,
//       price: json["price"],
//       discountedPrice: json["discounted_price"],
//       duration: json["duration"],
//       mainImageId: json["main_image_id"],
//     );
//   }

//   // ✅ Convert to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       "title": title,
//       "description": description,
//       "category_id": categoryId,
//       "sub_category_id": subCategoryId,
//       "thumbnail": thumbnail,
//       "price": price,
//       "discounted_price": discountedPrice,
//       "duration": duration,
//       "main_image_id": mainImageId,
//     };
//   }

//   // ✅ Clone object
//   ServiceVersion copyWith({
//     String? title,
//     String? description,
//     String? categoryId,
//     String? subCategoryId,
//     MultipartFile? thumbnail,
//     String? price,
//     String? discountedPrice,
//     int? duration,
//     int? mainImageId,
//   }) {
//     return ServiceVersion(
//       title: title ?? this.title,
//       description: description ?? this.description,
//       categoryId: categoryId ?? this.categoryId,
//       subCategoryId: subCategoryId ?? this.subCategoryId,
//       thumbnail: thumbnail ?? this.thumbnail,
//       price: price ?? this.price,
//       discountedPrice: discountedPrice ?? this.discountedPrice,
//       duration: duration ?? this.duration,
//       mainImageId: mainImageId ?? this.mainImageId,
//     );
//   }
// }
