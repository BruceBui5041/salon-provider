import 'package:salon_provider/model/response/payment_qr_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'payment_response.g.dart';

@JsonSerializable()
class Payment {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "created_at")
  final DateTime? createdAt;
  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;
  @JsonKey(name: "user_id")
  final int? userId;
  @JsonKey(name: "amount")
  final int? amount;
  @JsonKey(name: "currency")
  final String? currency;
  @JsonKey(name: "payment_method")
  final String? paymentMethod;
  @JsonKey(name: "transaction_id")
  final String? transactionId;
  @JsonKey(name: "transaction_status")
  final String? transactionStatus;
  @JsonKey(name: "payment_qr")
  final PaymentQr? paymentQr;

  Payment({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.amount,
    required this.currency,
    required this.paymentMethod,
    required this.transactionId,
    required this.transactionStatus,
    required this.paymentQr,
  });

  Payment copyWith({
    String? id,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? userId,
    int? amount,
    String? currency,
    String? paymentMethod,
    String? transactionId,
    String? transactionStatus,
    PaymentQr? paymentQr,
  }) =>
      Payment(
        id: id ?? this.id,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        userId: userId ?? this.userId,
        amount: amount ?? this.amount,
        currency: currency ?? this.currency,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        transactionId: transactionId ?? this.transactionId,
        transactionStatus: transactionStatus ?? this.transactionStatus,
        paymentQr: paymentQr ?? this.paymentQr,
      );

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}
