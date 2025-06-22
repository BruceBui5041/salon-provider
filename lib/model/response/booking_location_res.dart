// type BookingLocation struct {
// 	common.SQLModel     `json:",inline"`
// 	BookingID           uint32   `json:"booking_id" gorm:"column:booking_id;not null;uniqueIndex"`
// 	Booking             *Booking `json:"booking,omitempty" gorm:"foreignKey:BookingID"`
// 	ServiceManAddressID *uint32  `json:"-" gorm:"column:service_man_address_id;index"`
// 	ServiceManAddress   *Address `json:"service_man_address,omitempty" gorm:"foreignKey:ServiceManAddressID"`
// 	CustomerAddressID   *uint32  `json:"-" gorm:"column:customer_address_id;index"`
// 	CustomerAddress     *Address `json:"customer_address,omitempty" gorm:"foreignKey:CustomerAddressID"`
// 	InitialDistance     uint32   `json:"initial_distance" gorm:"column:initial_distance;not null"`
// 	InitialDistanceText string   `json:"initial_distance_text" gorm:"column:initial_distance_text;type:varchar(255);not null"`
// 	InitialDuration     uint32   `json:"initial_duration" gorm:"column:initial_duration;not null"`
// 	InitialDurationText string   `json:"initial_duration_text" gorm:"column:initial_duration_text;type:varchar(255);not null"`
// }

import 'package:json_annotation/json_annotation.dart';
import 'package:salon_provider/model/response/address_res.dart';
import 'package:salon_provider/model/response/base_response.dart';
import 'package:salon_provider/model/response/booking_response.dart';

part 'booking_location_res.g.dart';

@JsonSerializable()
class BookingLocation extends CommonResponse {
  @JsonKey(name: 'initial_distance')
  final int? initialDistance;
  @JsonKey(name: 'initial_distance_text')
  final String? initialDistanceText;
  @JsonKey(name: 'initial_duration')
  final int? initialDuration;
  @JsonKey(name: 'initial_duration_text')
  final String? initialDurationText;

  @JsonKey(name: 'booking')
  Booking? booking;

  @JsonKey(name: 'service_man_address')
  Address? serviceManAddress;

  @JsonKey(name: 'customer_address')
  Address? customerAddress;

  BookingLocation({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.status,
    this.initialDistance,
    this.initialDistanceText,
    this.initialDuration,
    this.initialDurationText,
    this.booking,
  });

  factory BookingLocation.fromJson(Map<String, dynamic> json) =>
      _$BookingLocationFromJson(json);

  Map<String, dynamic> toJson() => _$BookingLocationToJson(this);
}
