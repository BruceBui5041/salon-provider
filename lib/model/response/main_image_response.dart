import 'package:json_annotation/json_annotation.dart';
import 'package:salon_provider/model/response/base_response.dart';
part 'main_image_response.g.dart';

@JsonSerializable()
class MainImageResponse extends CommonResponse {
  String? type;
  String? url;

  MainImageResponse({
    super.id,
    super.createdAt,
    super.updatedAt,
    super.status,
    this.type,
    this.url,
  });

  MainImageResponse copyWith({
    String? id,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
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
