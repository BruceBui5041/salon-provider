import 'package:salon_provider/config.dart';
import '../../model/response/booking_response.dart';

class CancelledBookingProvider with ChangeNotifier {
  Booking? cancelledBookingModel;

  onReady(context) {
    // TODO: Update this to use proper booking data
    cancelledBookingModel = Booking.fromJson(appArray.cancelledBookingList);
    notifyListeners();
  }

  showBookingStatus(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return BookingStatusDialog();
        });
  }
}
