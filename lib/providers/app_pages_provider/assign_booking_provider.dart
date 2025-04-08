import 'dart:developer';

import 'package:salon_provider/config.dart';
import '../../model/pending_booking_model.dart';

class AssignBookingProvider with ChangeNotifier {
  PendingBookingModel? assignBookingModel;
  bool isServicemen = false;
  String? amount;

  TextEditingController reasonCtrl = TextEditingController();
  FocusNode reasonFocus = FocusNode();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  onReady(context) {
    if (isFreelancer != true) {
      dynamic data = ModalRoute.of(context)!.settings.arguments ?? "";
      log("AMOUNT DSAT $data");
      if (data != "") {
        isServicemen = data["bool"];
        amount = data["amount"];
      }
    }

    assignBookingModel = PendingBookingModel.fromJson(isServicemen
        ? appArray.assignBookingDetailWithList
        : appArray.assignBookingDetailList);
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

  onStartServicePass(context) {
    showDialog(
        context: context,
        builder: (context1) {
          return AlertDialogCommon(
              title: appFonts.startService,
              image: eGifAssets.rocket,
              subtext: appFonts.areYouSureStartService,
              height: Sizes.s145,
              isTwoButton: true,
              firstBText: appFonts.cancel,
              secondBText: appFonts.yes,
              firstBTap: () => route.pop(context),
              secondBTap: () {
                route.pop(context);
                if (isFreelancer) {
                  route.pushNamed(context, routeName.ongoingBooking);
                } else {
                  route.pushNamed(context, routeName.ongoingBooking,
                      arg: {"amount": amount});
                }
              });
        });
  }

  onCancel(context) {
    showDialog(
        context: context,
        builder: (context1) {
          return AlertDialogCommon(
              isTwoButton: true,
              title: appFonts.cancelService,
              image: eGifAssets.error,
              subtext: appFonts.areYouSureCancelService,
              height: Sizes.s145,
              firstBTap: () => route.pop(context),
              secondBTap: () {
                route.pop(context);
                showDialog(
                    context: context,
                    builder: (context1) => AppAlertDialogCommon(
                          globalKey: formKey,
                          isField: true,
                          focusNode: reasonFocus,
                          validator: (val) =>
                              validation.commonValidation(context, val),
                          controller: reasonCtrl,
                          title: appFonts.reasonOfCancelBooking,
                          singleText: appFonts.send,
                          singleTap: () {
                            if (formKey.currentState!.validate()) {
                              route.pop(context);
                              route.pop(context);
                              route.pushNamed(
                                  context, routeName.cancelledBooking);
                            }
                          },
                        ));
              },
              secondBText: appFonts.yes,
              firstBText: appFonts.cancel);
        });
  }
}
