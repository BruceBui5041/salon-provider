import 'package:json_annotation/json_annotation.dart';

part 'location_req.g.dart';

@JsonSerializable()
class ReverseGeocodeReq {
  @JsonKey(name: "latlng")
  String? latlng; // "latlng": "10.791878471000075,106.69549369900005"

  ReverseGeocodeReq({this.latlng});

  factory ReverseGeocodeReq.fromJson(Map<String, dynamic> json) =>
      _$ReverseGeocodeReqFromJson(json);
  Map<String, dynamic> toJson() => _$ReverseGeocodeReqToJson(this);
}
