import 'package:salon_provider/model/response/base_response.dart';
import 'package:salon_provider/model/response/booking_response.dart';
import 'package:salon_provider/model/response/payment_qr_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:salon_provider/model/response/user_response.dart';
import 'package:salon_provider/common/payment_method.dart';
import 'package:salon_provider/common/transaction_status.dart';
part 'payment_response.g.dart';

@JsonSerializable()
class Payment extends CommonResponse {
  @JsonKey(name: "user_id")
  final String? userId;
  @JsonKey(name: "amount")
  final double? amount;
  @JsonKey(name: "currency")
  final String? currency;
  @JsonKey(name: "payment_method")
  final PaymentMethod? paymentMethod;
  @JsonKey(name: "transaction_id")
  final String? transactionId;
  @JsonKey(name: "transaction_status")
  final TransactionStatus? transactionStatus;
  @JsonKey(name: "payment_qr")
  final PaymentQr? paymentQr;
  @JsonKey(name: "payment_qr_id")
  final String? paymentQrId;

  @JsonKey(name: "booking")
  final Booking? booking;
  @JsonKey(name: "booking_id")
  final String? bookingId;

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
    this.paymentQrId,
    required this.booking,
    this.bookingId,
    required this.user,
  });

  Payment copyWith({
    String? id,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userId,
    double? amount,
    String? currency,
    PaymentMethod? paymentMethod,
    String? transactionId,
    TransactionStatus? transactionStatus,
    PaymentQr? paymentQr,
    String? paymentQrId,
    Booking? booking,
    String? bookingId,
    UserResponse? user,
  }) =>
      Payment(
        id: id ?? this.id,
        booking: booking ?? this.booking,
        bookingId: bookingId ?? this.bookingId,
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
        paymentQrId: paymentQrId ?? this.paymentQrId,
      );

  getPaymentMethod() {
    return paymentMethod?.value.toLowerCase();
  }

  getTransactionStatus() {
    return transactionStatus?.value.toLowerCase();
  }

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}
