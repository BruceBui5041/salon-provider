import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'value')
enum PaymentMethod {
  @JsonValue("cash")
  cash("cash"),

  @JsonValue("transfer")
  transfer("transfer");

  final String value;
  const PaymentMethod(this.value);

  // Convert a string to a valid payment method
  static PaymentMethod fromString(String method) {
    switch (method.toLowerCase()) {
      case "cash":
        return PaymentMethod.cash;
      case "transfer":
        return PaymentMethod.transfer;
      default:
        throw ArgumentError('Invalid payment method: $method');
    }
  }

  String toLowerCase() {
    return value.toLowerCase();
  }
}
