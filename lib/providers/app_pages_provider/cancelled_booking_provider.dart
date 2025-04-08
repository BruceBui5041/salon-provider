import 'package:salon_provider/config.dart';
import '../../model/pending_booking_model.dart';

class CancelledBookingProvider with ChangeNotifier {
  PendingBookingModel? cancelledBookingModel;

  onReady(context) {
    cancelledBookingModel =
        PendingBookingModel.fromJson(appArray.cancelledBookingList);
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
