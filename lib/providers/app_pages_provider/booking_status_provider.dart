import 'package:salon_provider/config.dart';
import 'package:salon_provider/model/response/notification_res.dart';
import 'package:salon_provider/repositories/notification_repository.dart';
import 'package:salon_provider/model/request/search_request_model.dart';
import 'package:salon_provider/common/booking_status.dart';

class BookingStatusProvider with ChangeNotifier {
  final NotificationRepository _repository = NotificationRepository();
  List<NotificationRes> notifications = [];
  bool isLoading = false;
  String? error;
  int selectedStatusIndex = 0;

  String getEventTitle(String? event) {
    switch (event) {
      case 'booking_created':
        return 'Booking Created';
      case 'booking_accepted':
        return 'Booking Accepted';
      case 'booking_confirmed_paid':
        return 'Payment Confirmed';
      case 'booking_in_progress':
        return 'Service Started';
      case 'booking_completed':
        return 'Booking Completed';
      case 'booking_cancelled':
        return 'Booking Cancelled';
      default:
        return event
                ?.split('_')
                .map((word) => word.isEmpty
                    ? ''
                    : '${word[0].toUpperCase()}${word.substring(1)}')
                .join(' ') ??
            '';
    }
  }

  String getEventDescription(NotificationRes notification) {
    final metadata = notification.metadata ?? {};
    final event = metadata['event'] as String?;
    final booking = notification.booking;

    if (event == null || booking == null) return '';

    final user = booking.user;
    final serviceMan = booking.serviceMan;
    final serviceVersions = booking.serviceVersions;

    final userName = user != null ? '${user.firstname} ${user.lastname}' : '';
    final userPhone = user?.phoneNumber ?? '';
    final serviceManName = serviceMan != null
        ? '${serviceMan.firstname} ${serviceMan.lastname}'
        : '';
    final serviceManPhone = serviceMan?.phoneNumber ?? '';
    final serviceTitles =
        serviceVersions?.map((sv) => sv.title).join(', ') ?? '';

    switch (event) {
      case 'booking_created':
        return 'Booking created by Customer $userName ($userPhone) for services: $serviceTitles';
      case 'booking_accepted':
        return 'Booking accepted by service provider $serviceManName ($serviceManPhone)';
      case 'booking_confirmed_paid':
        return 'Payment has been confirmed for this booking';
      case 'booking_in_progress':
        return 'Service started by provider $serviceManName';
      case 'booking_completed':
        return 'Booking completed by service provider $serviceManName';
      case 'booking_cancelled':
        final cancelledBy = metadata['cancelled_by'] == 'user'
            ? 'Customer $userName'
            : 'Provider $serviceManName';
        return 'Booking cancelled by $cancelledBy';
      default:
        return '';
    }
  }

  Color getStatusColor(BuildContext context, String? event) {
    if (event == null) return appColor(context).appTheme.darkText;

    switch (event.toLowerCase()) {
      case 'booking_created':
        return appColor(context).appTheme.primary;
      case 'booking_accepted':
        return appColor(context).appTheme.green;
      case 'booking_confirmed_paid':
        return appColor(context).appTheme.green;
      case 'booking_in_progress':
        return appColor(context).appTheme.assign;
      case 'booking_completed':
        return appColor(context).appTheme.green;
      case 'booking_cancelled':
        return appColor(context).appTheme.red;
      default:
        return appColor(context).appTheme.primary;
    }
  }

  Future<void> getBookingNotifications(String? bookingId) async {
    if (bookingId == null) {
      notifications = [];
      notifyListeners();
      return;
    }

    try {
      isLoading = true;
      notifyListeners();

      final conditions = [
        [
          Condition(
            source: "booking.id",
            operator: "=",
            target: bookingId,
          )
        ]
      ];

      notifications = await _repository.getNotifications(
        conditions: conditions,
      );

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      error = e.toString();
      notifyListeners();
    }
  }

  void selectStatus(int index) {
    selectedStatusIndex = index;
    notifyListeners();
  }
}
