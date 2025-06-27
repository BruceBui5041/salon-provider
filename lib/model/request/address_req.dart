import 'package:json_annotation/json_annotation.dart';

part 'address_req.g.dart';

@JsonSerializable()
class ChooseCurrentAddressReq {
  @JsonKey(name: "address_id")
  String? addressId;

  @JsonKey(name: "lat")
  String? latitude;

  @JsonKey(name: "lng")
  String? longitude;

  @JsonKey(name: "address")
  String? text;

  ChooseCurrentAddressReq({
    this.addressId,
    this.latitude,
    this.longitude,
    this.text,
  });

  factory ChooseCurrentAddressReq.fromJson(Map<String, dynamic> json) =>
      _$ChooseCurrentAddressReqFromJson(json);
  Map<String, dynamic> toJson() => _$ChooseCurrentAddressReqToJson(this);
}
