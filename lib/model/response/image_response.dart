import 'package:json_annotation/json_annotation.dart';
part 'image_response.g.dart';

@JsonSerializable()
class ImageResponse {
  String? id;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? type;
  String? url;

  ImageResponse(
      {this.id,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.type,
      this.url});

  factory ImageResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ImageResponseToJson(this);
}
