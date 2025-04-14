import 'package:json_annotation/json_annotation.dart';

part 'cancel_req.g.dart';

@JsonSerializable()
class CancelReq {
  @JsonKey(name: "cancellation_reason")
  String? cancellationReason;

  CancelReq({this.cancellationReason});

  factory CancelReq.fromJson(Map<String, dynamic> json) =>
      _$CancelReqFromJson(json);
  Map<String, dynamic> toJson() => _$CancelReqToJson(this);
}
