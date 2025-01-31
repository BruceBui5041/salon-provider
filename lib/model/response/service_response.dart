// import 'package:json_annotation/json_annotation.dart';

// import 'dart:io';

// part 'service_version_res_dto.g.dart';

// @JsonSerializable(explicitToJson: true)
// class ServiceVersionResponse extends CommonResDTO {
//   final String title;
//   final String description;
//   final CategoryResponse category;

//   @JsonKey(name: 'sub_category')
//   final CategoryResponse subCategory;

//   final UserResponseDTO creator;

//   final List<UserResponseDTO> instructors;

//   final String slug;
//   final String thumbnail;

//   @JsonKey(name: 'thumbnailFile')
//   final File? thumbnailFile;

//   final String? price;

//   @JsonKey(name: 'discounted_price')
//   final String? discountedPrice;

//   final int? duration;

//   final int? servicemen;

//   @JsonKey(name: 'intro_video')
//   final VideoResDTO introVideo;

//   @JsonKey(name: 'published_date')
//   final String? publishedDate;

//   @JsonKey(name: 'main_image')
//   final ImageResDTO? mainImage;

//   final List<ImageResDTO>? images;

//   final List<VideoResDTO> videos;

//   @JsonKey(name: 'review_info')
//   final List<ReviewStar> reviewInfo;

//   @JsonKey(name: 'avg_rating')
//   final String avgRating;

//   @JsonKey(name: 'rating_count')
//   final int ratingCount;

//   ServiceVersionResponse({
//     String? updatedAt,
//     String? createdAt,
//     required String id,
//     Status? status,
//     required this.title,
//     required this.description,
//     required this.category,
//     required this.subCategory,
//     required this.creator,
//     required this.instructors,
//     required this.slug,
//     required this.thumbnail,
//     this.thumbnailFile,
//     this.price,
//     this.discountedPrice,
//     this.duration,
//     this.servicemen,
//     required this.introVideo,
//     this.publishedDate,
//     this.mainImage,
//     this.images,
//     required this.videos,
//     required this.reviewInfo,
//     required this.avgRating,
//     required this.ratingCount,
//   }) : super(
//           updatedAt: updatedAt,
//           createdAt: createdAt,
//           id: id,
//           status: status,
//         );

//   factory ServiceVersionResponse.fromJson(Map<String, dynamic> json) =>
//       _$ServiceVersionResDTOFromJson(json);

//   @override
//   Map<String, dynamic> toJson() => _$ServiceVersionResDTOToJson(this);
// }