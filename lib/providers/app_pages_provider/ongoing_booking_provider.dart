import 'dart:developer';

import 'package:salon_provider/config.dart';
import '../../model/pending_booking_model.dart';

class OngoingBookingProvider with ChangeNotifier {
  PendingBookingModel? ongoingBookingModel;
  String? amount;
  bool isServicemen = false;
  TextEditingController reasonCtrl = TextEditingController();
  onReady(context) {
    if (isFreelancer) {
      isServicemen = false;
    }
    if (isFreelancer != true) {
      dynamic data = ModalRoute.of(context)!.settings.arguments ?? "";
      log("DATATAAATA ${data}");
      if (data != null) {
        amount = data["amount"];
        isServicemen = data["bool"] ?? false;
      }
    }
    ongoingBookingModel = PendingBookingModel.fromJson(isServicemen
        ? appArray.ongoingBookingWithList
        : appArray.ongoingBookingList);
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
