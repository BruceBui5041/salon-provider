import 'dart:developer';

import 'package:salon_provider/common/enum_value.dart';
import 'package:salon_provider/config.dart';
import 'package:salon_provider/config/injection_config.dart';
import '../../model/pending_booking_model.dart';

class AcceptedBookingProvider with ChangeNotifier {
  PendingBookingModel? acceptedBookingModel;
  int selectIndex = 0;
  List statusList = [];
  String amount = "0";
  bool? isAssign = false;

  TextEditingController amountCtrl = TextEditingController();

  FocusNode amountFocus = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void listenAcceptedBooking(BuildContext context) {
    getIt.get<NotificationProvider>().onSubcribeCloudMessage(
      onCallBack: (message) {
        if (message.event == NotificationEventEnum.booking_accepted.name) {
          return;
        }
        onReady(context);
        // event get
      },
    );
  }

  onReady(context) {
    if (isFreelancer != true) {
      dynamic data = ModalRoute.of(context)!.settings.arguments ?? "";
      log("MHGGGGBBJVVJV $data");
      if (data != "") {
        amount = data["amount"] ?? "0";
        isAssign = data["assign_me"] ?? false;
      }
    }

    acceptedBookingModel = PendingBookingModel.fromJson(isAssign == true
        ? appArray.acceptBookingDetailWithList
        : appArray.acceptBookingDetailList);

    notifyListeners();
  }

  onServicemenChange(index) {
    selectIndex = index;
    notifyListeners();
  }

  showBookingStatus(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return BookingStatusDialog(bookingId: acceptedBookingModel?.bookingId);
      },
    );
  }

  onAssignTap(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context1) {
          return SelectServicemenSheet(
              arguments: acceptedBookingModel!.requiredServicemen);
        });
  }

  onTapContinue(context, arguments) {
    if (selectIndex == 0) {
      showDialog(
          context: context,
          builder: (context1) => AppAlertDialogCommon(
              height: Sizes.s145,
              title: appFonts.assignToMe,
              firstBText: appFonts.cancel,
              secondBText: appFonts.yes,
              image: eImageAssets.assignMe,
              subtext: appFonts.areYouSureYourself,
              secondBTap: () {
                route.pop(context);
                route.pop(context);
                route.pushNamed(context, routeName.assignBooking);
              },
              firstBTap: () {
                route.pop(context);
                route.pop(context);
              }));
    } else {
      if (amountCtrl.text.isEmpty) {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => ServicemenChargesSheet(
                focusNode: amountFocus,
                controller: amountCtrl,
                formKey: formKey,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    route.pop(context);
                  }
                  notifyListeners();
                }));
      } else {
        log("ARGSSSSMGVHF $arguments");
        route.pushNamed(context, routeName.bookingServicemenList,
            arg: {"servicemen": arguments, "amount": amountCtrl.text});
      }
    }
  }
}
