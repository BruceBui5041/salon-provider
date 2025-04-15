import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'value')
enum TransactionStatus {
  @JsonValue("pending")
  pending("pending"),

  @JsonValue("completed")
  completed("completed"),

  @JsonValue("cancelled")
  failed("cancelled");

  final String value;
  const TransactionStatus(this.value);

  // Convert a string to a valid transaction status
  static TransactionStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case "pending":
        return TransactionStatus.pending;
      case "completed":
        return TransactionStatus.completed;
      case "cancelled":
        return TransactionStatus.failed;
      default:
        throw ArgumentError('Invalid transaction status: $status');
    }
  }

  String toLowerCase() {
    return value.toLowerCase();
  }
}
