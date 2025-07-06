import 'package:salon_provider/config.dart';
import 'package:salon_provider/model/response/notification_res.dart';
import 'package:salon_provider/repositories/notification_repository.dart';
import 'package:salon_provider/model/request/search_request_model.dart';

class BookingStatusProvider with ChangeNotifier {
  final NotificationRepository _repository = NotificationRepository();
  List<NotificationRes> notifications = [];
  bool isLoading = false;
  String? error;
  int selectedStatusIndex = 0;

  String getEventTitle(String? event) {
    return getBookingEventTitle(event);
  }

  String getEventDescription(
      BuildContext context, NotificationRes notification) {
    final metadata = notification.metadata ?? {};
    final event = metadata['event'] as String?;
    final booking = notification.booking;

    if (event == null || booking == null) return '';

    final user = booking.user;
    final serviceMan = booking.serviceMan;
    final serviceVersions = booking.serviceVersions;
    final bookingId = booking.id ?? '';

    final userName = user != null
        ? '${user.firstname ?? ''} ${user.lastname ?? ''}'.trim()
        : language(context, appFonts.customer);
    final userPhone = user?.phoneNumber ?? '';
    final serviceManName = serviceMan != null
        ? '${serviceMan.firstname ?? ''} ${serviceMan.lastname ?? ''}'.trim()
        : 'Serviceman';
    final serviceTitles =
        serviceVersions?.map((sv) => sv.title).join(', ') ?? 'Service';

    return getBookingEventDescription(
      context,
      event: event,
      metadata: metadata,
      bookingId: bookingId,
      userName: userName,
      userPhone: userPhone,
      serviceManName: serviceManName,
      serviceTitles: serviceTitles,
    );
  }

  Color getStatusColor(BuildContext context, String? event) {
    return getBookingEventStatusColor(context, event);
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
