import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'value')
enum BookingStatus {
  @JsonValue("pending")
  pending("pending"),

  @JsonValue("confirmed")
  confirmed("confirmed"),

  @JsonValue("in_progress")
  inProgress("in_progress"),

  @JsonValue("completed")
  completed("completed"),

  @JsonValue("cancelled")
  cancelled("cancelled");

  final String value;
  const BookingStatus(this.value);

  // Convert a string to a valid booking status
  static BookingStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case "pending":
        return BookingStatus.pending;
      case "confirmed":
        return BookingStatus.confirmed;
      case "in_progress":
      case "inprogress":
        return BookingStatus.inProgress;
      case "completed":
        return BookingStatus.completed;
      case "cancelled":
      case "canceled":
        return BookingStatus.cancelled;
      default:
        throw ArgumentError('Invalid booking status: $status');
    }
  }

  String toLowerCase() {
    return value.toLowerCase();
  }
}
