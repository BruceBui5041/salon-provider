import 'package:json_annotation/json_annotation.dart';
part 'main_image_response.g.dart';

@JsonSerializable()
class MainImageResponse {
  String? id;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? type;
  String? url;

  MainImageResponse(
      {this.id,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.type,
      this.url});

  MainImageResponse copyWith({
    String? id,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? type,
    String? url,
  }) =>
      MainImageResponse(
        id: id ?? this.id,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        type: type ?? this.type,
        url: url ?? this.url,
      );

  factory MainImageResponse.fromJson(Map<String, dynamic> json) =>
      _$MainImageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MainImageResponseToJson(this);
}
