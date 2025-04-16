import 'package:json_annotation/json_annotation.dart';

part 'generate_qr_req.g.dart';

@JsonSerializable()
class GenerateQRReq {
  @JsonKey(name: "payment_id")
  final String paymentId;
  @JsonKey(name: "bank_account_id")
  final String bankAccountId;
  @JsonKey(name: "format")
  String? format;
  @JsonKey(name: "template")
  String? template;

  GenerateQRReq({
    required this.paymentId,
    required this.bankAccountId,
    this.format,
    this.template,
  }) {
    format = format ?? "png";
    template = template ?? "compact";
  }

  Map<String, dynamic> toJson() => _$GenerateQRReqToJson(this);

  factory GenerateQRReq.fromJson(Map<String, dynamic> json) =>
      _$GenerateQRReqFromJson(json);
}
