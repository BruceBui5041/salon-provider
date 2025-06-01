import 'package:salon_provider/common/enum_value.dart';
import 'package:salon_provider/config.dart';
import 'package:salon_provider/config/injection_config.dart';
import '../../model/pending_booking_model.dart';

class HoldBookingProvider with ChangeNotifier {
  String amount = "0";

  PendingBookingModel? holdBookingModel;

  TextEditingController reasonCtrl = TextEditingController();
  void listenHoldBooking(BuildContext context) {
    getIt.get<NotificationProvider>().onSubcribeCloudMessage(
      onCallBack: (message) {
        if (message.event == NotificationEventEnum.booking_in_progress.name) {
          return;
        }

        // event get
      },
    );
  }

  onReady(context) {
    holdBookingModel = PendingBookingModel.fromJson(appArray.holdBookingList);
    notifyListeners();
  }

  showBookingStatus(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return BookingStatusDialog(bookingId: holdBookingModel?.bookingId);
      },
    );
  }
}
