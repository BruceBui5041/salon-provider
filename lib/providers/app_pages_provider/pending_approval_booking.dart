import 'package:fixit_provider/config.dart';

import '../../model/pending_booking_model.dart';

class PendingApprovalBookingProvider with ChangeNotifier {

  PendingBookingModel? pendingApprovalBookingModel;
  List statusList = [];
  String amount = "0";

  TextEditingController reasonCtrl = TextEditingController();
  onReady(context){
    pendingApprovalBookingModel = PendingBookingModel.fromJson(appArray.pendingApprovalBookingList);
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