import 'dart:developer';

import 'package:salon_provider/config.dart';
import 'package:salon_provider/repositories/booking_repository.dart';
import 'package:salon_provider/repositories/chat_repository.dart';
import '../../model/response/booking_response.dart';

class CancelledBookingProvider with ChangeNotifier {
  Booking? cancelledBooking;
  final BookingRepository _bookingRepository;

  CancelledBookingProvider(this._bookingRepository);

  onReady(context) async {
    String bookingId = ModalRoute.of(context)!.settings.arguments as String;
    await _bookingRepository.getBookingByIdBooking(bookingId).then((value) {
      cancelledBooking = value.first;
      notifyListeners();
    });
  }

  Future<void> openChat(BuildContext context) async {
    if (cancelledBooking?.id != null) {
      route.pushNamed(context, routeName.chat, arg: cancelledBooking!.id);
    }
  }

  showBookingStatus(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return BookingStatusDialog(bookingId: cancelledBooking?.id);
      },
    );
  }
}
