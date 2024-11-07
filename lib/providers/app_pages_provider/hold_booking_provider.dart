import 'package:fixit_provider/config.dart';
import '../../model/pending_booking_model.dart';

class HoldBookingProvider with ChangeNotifier {

  String amount = "0";

  PendingBookingModel? holdBookingModel;

  TextEditingController reasonCtrl = TextEditingController();
  onReady(context){
    holdBookingModel = PendingBookingModel.fromJson(appArray.holdBookingList);
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