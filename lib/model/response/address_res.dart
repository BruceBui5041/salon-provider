// type Address struct {
// 	common.SQLModel `json:",inline"`
// 	Type            string  `json:"type" gorm:"column:type;type:varchar(255)"`
// 	Default         *bool   `json:"default" gorm:"column:default;type:tinyint(1);default:0"`
// 	UserId          uint32  `json:"-" gorm:"column:user_id;not null;index"`
// 	User            *User   `json:"user,omitempty" gorm:"foreignKey:UserId"`
// 	Text            string  `json:"text" gorm:"column:text;type:text;not null"`
// 	Latitude        float64 `json:"latitude" gorm:"column:latitude;type:decimal(10,8);not null;index"`
// 	Longitude       float64 `json:"longitude" gorm:"column:longitude;type:decimal(11,8);not null;index"`
// }

import 'package:json_annotation/json_annotation.dart';
import 'package:salon_provider/model/response/base_response.dart';

part 'address_res.g.dart';

@JsonSerializable()
class Address extends CommonResponse {
  final String? type;
  final bool? isDefault;
  final String? text;
  final double? latitude;
  final double? longitude;

  Address({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.status,
    this.type,
    this.isDefault,
    this.text,
    this.latitude,
    this.longitude,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
