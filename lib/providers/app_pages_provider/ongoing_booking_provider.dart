import 'dart:convert';
import 'dart:developer';

import 'package:provider/provider.dart';
import 'package:salon_provider/config.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/model/response/booking_response.dart';
import 'package:salon_provider/repositories/booking_repository.dart';
import 'package:salon_provider/common/payment_method.dart';
import 'package:salon_provider/common/transaction_status.dart';
import 'package:salon_provider/screens/app_pages_screens/ongoing_booking_screen/layouts/show_qr_dialog.dart';
import 'package:salon_provider/screens/app_pages_screens/ongoing_booking_screen/layouts/change_payment_method.dart';

class OngoingBookingProvider with ChangeNotifier {
  Booking? ongoingBookingModel;
  String? amount;
  bool isServicemen = false;
  TextEditingController reasonCtrl = TextEditingController();
  final BookingRepository bookingRepository = getIt<BookingRepository>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FocusNode reasonFocus = FocusNode();

  // Updated payment status properties to use enum values directly
  bool get isPaymentPending =>
      ongoingBookingModel?.payment?.transactionStatus ==
      TransactionStatus.pending;
  bool get isPaymentCompleted =>
      ongoingBookingModel?.payment?.transactionStatus ==
      TransactionStatus.completed;
  bool get isTransferPayment =>
      ongoingBookingModel?.payment?.paymentMethod == PaymentMethod.transfer;
  bool get isCashPayment =>
      ongoingBookingModel?.payment?.paymentMethod == PaymentMethod.cash;
  // Check if payment has QR code
  bool get hasPaymentQr => ongoingBookingModel?.payment?.paymentQr != null;

  onReady(context) {
    if (isFreelancer) {
      isServicemen = false;
    }

    // Get booking ID from route arguments
    dynamic bookingId = ModalRoute.of(context)!.settings.arguments as String;

    if (bookingId.isNotEmpty) {
      // Fetch booking from repository
      bookingRepository.getBookingByIdBooking(bookingId).then((value) {
        if (value.isNotEmpty) {
          ongoingBookingModel = value.first;
          notifyListeners();
        }
      });
    } else {
      // Fallback to mock data if needed
      // This will be removed in production
      log("Using mock data for ongoing booking");
      // Create mock data based on Booking model
      notifyListeners();
    }
  }

  showBookingStatus(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return BookingStatusDialog(bookingId: ongoingBookingModel?.id);
      },
    );
  }

  onStartServicePass(context) {
    // Get booking ID from the model
    String? bookingId = ongoingBookingModel?.id;

    if (bookingId != null) {
      bookingRepository.inProgressBooking(bookingId).then((value) {
        if (value) {
          route.pushNamed(context, routeName.ongoingBooking, arg: bookingId);
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
    }
  }

  // Method to mark payment as completed
  markPaymentPaid(context) async {
    String? bookingId = ongoingBookingModel?.id;
    if (bookingId != null) {
      // Show payment method selection bottom sheet
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => ChangePaymentMethodSheet(
          initialMethod: ongoingBookingModel?.payment?.paymentMethod,
          onContinue: (selectedMethod, bottomSheetContext) {
            if (selectedMethod == PaymentMethod.cash) {
              showDialog(
                context: bottomSheetContext,
                barrierDismissible: false,
                builder: (dialogContext) => AppAlertDialogCommon(
                  title: appFonts.payment,
                  subtext: language(
                      bottomSheetContext, appFonts.areYouSureToCompleteBooking),
                  firstBText: appFonts.no,
                  secondBText: appFonts.yes,
                  image: eGifAssets.dateGif,
                  height: Sizes.s145,
                  firstBTap: () {
                    route.pop(dialogContext);
                  },
                  secondBTap: () async {
                    route.pop(dialogContext);
                    try {
                      final result =
                          await bookingRepository.paidBooking(bookingId);
                      if (result) {
                        if (ongoingBookingModel?.payment != null) {
                          ongoingBookingModel = ongoingBookingModel?.copyWith(
                              payment: ongoingBookingModel?.payment?.copyWith(
                                  transactionStatus:
                                      TransactionStatus.completed));
                          notifyListeners();
                        }
                        showDialog(
                          context: bottomSheetContext,
                          builder: (successContext) => AlertDialogCommon(
                            title: appFonts.payment,
                            image: eGifAssets.success,
                            subtext: language(bottomSheetContext,
                                appFonts.updateSuccessfully),
                            height: Sizes.s145,
                            bText1: appFonts.okay,
                            b1OnTap: () => route.pop(successContext),
                          ),
                        );
                      }
                    } catch (error) {
                      log("Error marking payment as completed: $error");
                      showDialog(
                        context: bottomSheetContext,
                        builder: (errorContext) => AlertDialogCommon(
                          title: appFonts.errorOccur,
                          image: eGifAssets.error,
                          subtext: language(
                              bottomSheetContext, appFonts.oppsThereHas),
                          height: Sizes.s145,
                          bText1: appFonts.okay,
                          b1OnTap: () => route.pop(errorContext),
                        ),
                      );
                    }
                  },
                ),
              );
            } else if (selectedMethod == PaymentMethod.transfer) {
              // Navigate to payment QR screen with payment ID
              if (ongoingBookingModel?.payment?.id != null) {
                route.pushNamed(bottomSheetContext, routeName.paymentQr,
                    arg: ongoingBookingModel!.payment!.id);
              }
            }
          },
        ),
      );
    }
  }

  void navigateToPaymentQr(BuildContext context) {
    // First check if we have a valid booking model
    if (ongoingBookingModel == null) {
      return;
    }

    // Then check if we have a payment
    if (ongoingBookingModel?.payment == null) {
      return;
    }

    // Finally check if we have a payment ID
    final paymentId = ongoingBookingModel?.payment?.id;
    if (paymentId == null || paymentId.isEmpty) {
      return;
    }

    if (ongoingBookingModel?.payment?.paymentQr != null) {
      // If QR exists, show QR dialog directly
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context1) => ShowQrDialog(booking: ongoingBookingModel!),
      );
    } else {
      // If no QR exists, navigate to QR screen
      route.pushNamed(
        context,
        routeName.paymentQr,
        arg: paymentId,
      );
    }
  }

  onCancelBooking(context) {
    showDialog(
        context: context,
        builder: (context1) => AppAlertDialogCommon(
            isField: true,
            validator: (value) => validation.commonValidation(context, value),
            focusNode: reasonFocus,
            controller: reasonCtrl,
            title: appFonts.reasonOfRejectBooking,
            singleText: appFonts.send,
            globalKey: formKey,
            singleTap: () {
              if (formKey.currentState!.validate()) {
                route.pop(context);
                bookingRepository
                    .cancelBooking(ongoingBookingModel!.id!, reasonCtrl.text)
                    .then((value) {
                  if (value) {
                    route.pop(context);
                    route.pushNamed(context, routeName.dashboard);
                  }
                });
              }
              notifyListeners();
            }));
  }
}
