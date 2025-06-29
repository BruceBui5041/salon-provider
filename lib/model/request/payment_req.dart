import 'package:json_annotation/json_annotation.dart';
import 'package:salon_provider/common/payment_method.dart';

part 'payment_req.g.dart';

@JsonSerializable()
class UpdatePaymentReq {
  @JsonKey(name: "payment_method")
  final PaymentMethod? paymentMethod;

  UpdatePaymentReq({this.paymentMethod});

  factory UpdatePaymentReq.fromJson(Map<String, dynamic> json) =>
      _$UpdatePaymentReqFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePaymentReqToJson(this);
}
