import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:salon_provider/common/booking_status.dart';
import 'package:salon_provider/config.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/model/response/booking_response.dart';
import 'package:salon_provider/repositories/booking_repository.dart';
import 'package:salon_provider/widgets/alert_dialog_common.dart';
import 'package:salon_provider/widgets/app_alert_dialog_common.dart';

class AssignBookingProvider with ChangeNotifier {
  Booking? booking;
  bool isServicemen = false;
  String? amount;
  final BookingRepository bookingRepository = getIt<BookingRepository>();

  TextEditingController reasonCtrl = TextEditingController();
  FocusNode reasonFocus = FocusNode();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  onReady(context) {
    // Get booking from route parameters or use default ID for testing
    String bookingId = ModalRoute.of(context)?.settings.arguments as String;

    // Fetch booking data from repository
    bookingRepository.getBookingByIdBooking(bookingId).then((value) {
      if (value.isNotEmpty) {
        booking = value.first;
        notifyListeners();
      }
    }).catchError((error) {
      log("Error fetching booking: $error");
    });
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
    if (booking != null) {
      showDialog(
        context: context,
        builder: (context1) => AppAlertDialogCommon(
          height: Sizes.s100,
          title: appFonts.startService,
          firstBText: appFonts.cancel,
          secondBText: appFonts.yes,
          image: eGifAssets.dateGif,
          subtext: appFonts.startService,
          firstBTap: () => route.pop(context),
          secondBTap: () {
            route.pop(context);
            bookingRepository.inProgressBooking(booking!.id!).then((value) {
              if (value) {
                route.popAndPushNamed(context, routeName.ongoingBooking,
                    arg: booking!.id);
              }
            }).catchError((error) {
              log("Error updating booking to in-progress: $error");
              showDialog(
                context: context,
                builder: (context1) => AlertDialogCommon(
                  title: appFonts.errorOccur,
                  image: eGifAssets.error,
                  subtext: appFonts.doYouWant,
                  height: Sizes.s145,
                  bText1: appFonts.okay,
                  b1OnTap: () => route.pop(context),
                ),
              );
            });
          },
        ),
      );
    }
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
                            if (formKey.currentState!.validate() &&
                                booking != null) {
                              bookingRepository
                                  .cancelBooking(booking!.id!, reasonCtrl.text)
                                  .then((value) {
                                if (value) {
                                  route.pop(context);
                                  route.pop(context);
                                  route.pushNamed(context, routeName.dashboard);
                                }
                              });
                            }
                          },
                        ));
              },
              secondBText: appFonts.yes,
              firstBText: appFonts.cancel);
        });
  }
}
