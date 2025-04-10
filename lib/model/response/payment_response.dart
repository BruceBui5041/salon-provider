import 'package:salon_provider/model/response/base_response.dart';
import 'package:salon_provider/model/response/booking_response.dart';
import 'package:salon_provider/model/response/payment_qr_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:salon_provider/model/response/user_response.dart';
part 'payment_response.g.dart';

@JsonSerializable()
class Payment extends CommonResponse {
  @JsonKey(name: "user_id")
  final int? userId;
  @JsonKey(name: "amount")
  final double? amount;
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

  @JsonKey(name: "booking")
  final ItemBooking? booking;

  @JsonKey(name: "user")
  final UserResponse? user;

  Payment({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.status,
    required this.userId,
    required this.amount,
    required this.currency,
    required this.paymentMethod,
    required this.transactionId,
    required this.transactionStatus,
    required this.paymentQr,
    required this.booking,
    required this.user,
  });

  Payment copyWith({
    String? id,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? userId,
    double? amount,
    String? currency,
    String? paymentMethod,
    String? transactionId,
    String? transactionStatus,
    PaymentQr? paymentQr,
    ItemBooking? booking,
    UserResponse? user,
  }) =>
      Payment(
        id: id ?? this.id,
        booking: booking ?? this.booking,
        user: user ?? this.user,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        status: status ?? this.status,
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
