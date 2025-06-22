// const (
// 	FeeTypePlatformFee    FeeType = "platform_fee"
// 	FeeTypeTravelFeePerKm FeeType = "travel_fee_per_km"
// )

import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'value')
enum FeeType {
  @JsonValue("platform_fee")
  platformFee("platform_fee"),
  @JsonValue("travel_fee_per_km")
  travelFeePerKm("travel_fee_per_km");

  final String value;
  const FeeType(this.value);

  static FeeType fromString(String value) {
    return FeeType.values.firstWhere((e) => e.value == value);
  }
}
