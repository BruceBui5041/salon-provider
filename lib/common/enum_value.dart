enum EnumColumn {
  service,
  booking,
  category,
  user,
  payment,
  bank_account,
  notifications,
  notification_details,
}

enum ServiceVersionStatus {
  active,
  inactive,
}

enum NotificationEventEnum {
  booking_created, // pending
  booking_accepted, // confirm
  booking_completed, // completed
  booking_in_progress, // in_progress / on_going
  booking_cancelled, // cancelled
  booking_confirmed_paid, // paid
  booking_transferred, // transferred

  // final String value;
}

enum Status {
  active,
  inactive,
  suspended,
  pending,
  revoked,
  accepted,
}

enum DiscountType {
  percentage,
  fixedPrice,
}

enum PaymentStatus {
  pending,
  cancelled,
  completed,
  refunded,
  error,
}

// Chuyển đổi enum sang string (nếu cần)
extension StatusExtension on Status {
  String get value {
    switch (this) {
      case Status.active:
        return 'active';
      case Status.inactive:
        return 'inactive';
      case Status.suspended:
        return 'suspended';
      case Status.pending:
        return 'pending';
      case Status.revoked:
        return 'revoked';
      case Status.accepted:
        return 'accepted';
    }
  }
}

extension DiscountTypeExtension on DiscountType {
  String get value {
    switch (this) {
      case DiscountType.percentage:
        return 'percentage';
      case DiscountType.fixedPrice:
        return 'fixed_price';
    }
  }
}

extension PaymentStatusExtension on PaymentStatus {
  String get value {
    switch (this) {
      case PaymentStatus.pending:
        return 'pending';
      case PaymentStatus.cancelled:
        return 'cancelled';
      case PaymentStatus.completed:
        return 'completed';
      case PaymentStatus.refunded:
        return 'refunded';
      case PaymentStatus.error:
        return 'error';
    }
  }
}
