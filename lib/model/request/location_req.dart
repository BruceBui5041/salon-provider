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

@JsonSerializable()
class AutoCompleteReq {
  @JsonKey(name: "input")
  String? input; // "input": "123 Main St"

  @JsonKey(name: "location")
  String? location; // "location": "10.791878471000075,106.69549369900005"

  AutoCompleteReq({this.input, this.location});

  factory AutoCompleteReq.fromJson(Map<String, dynamic> json) =>
      _$AutoCompleteReqFromJson(json);
  Map<String, dynamic> toJson() => _$AutoCompleteReqToJson(this);
}

@JsonSerializable()
class GeocodePlaceDetailReq {
  @JsonKey(name: "place_id")
  String? placeId; // "place_id": "ChIJN1t_t3u0GxQ3jNRRG61p6s"

  GeocodePlaceDetailReq({this.placeId});

  factory GeocodePlaceDetailReq.fromJson(Map<String, dynamic> json) =>
      _$GeocodePlaceDetailReqFromJson(json);
  Map<String, dynamic> toJson() => _$GeocodePlaceDetailReqToJson(this);
}
