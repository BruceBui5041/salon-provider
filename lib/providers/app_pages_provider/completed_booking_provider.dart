import 'package:fixit_provider/config.dart';
import '../../model/pending_booking_model.dart';

class CompletedBookingProvider with ChangeNotifier {

  PendingBookingModel? completedBookingModel;

  TextEditingController reasonCtrl = TextEditingController();
  onReady(context){
    completedBookingModel = PendingBookingModel.fromJson(appArray.completedBookingList);
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