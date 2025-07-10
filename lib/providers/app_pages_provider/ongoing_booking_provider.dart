import 'dart:developer';

import 'package:salon_provider/config.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/model/response/booking_response.dart';
import 'package:salon_provider/repositories/booking_repository.dart';
import 'package:salon_provider/repositories/payment_repository.dart';
import 'package:salon_provider/model/request/payment_req.dart';
import 'package:salon_provider/common/payment_method.dart';
import 'package:salon_provider/common/transaction_status.dart';
import 'package:salon_provider/screens/app_pages_screens/ongoing_booking_screen/layouts/change_payment_method.dart';

class OngoingBookingProvider with ChangeNotifier {
  Booking? ongoingBooking;
  String? amount;
  bool isServicemen = false;
  TextEditingController reasonCtrl = TextEditingController();
  final BookingRepository bookingRepository = getIt<BookingRepository>();
  final PaymentRepository paymentRepository = getIt<PaymentRepository>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FocusNode reasonFocus = FocusNode();

  // Updated payment status properties to use enum values directly
  bool get isPaymentPending =>
      ongoingBooking?.payment?.transactionStatus == TransactionStatus.pending;
  bool get isPaymentCompleted =>
      ongoingBooking?.payment?.transactionStatus == TransactionStatus.completed;
  bool get isTransferPayment =>
      ongoingBooking?.payment?.paymentMethod == PaymentMethod.transfer;
  bool get isCashPayment =>
      ongoingBooking?.payment?.paymentMethod == PaymentMethod.cash;
  // Check if payment has QR code
  bool get hasPaymentQr => ongoingBooking?.payment?.paymentQr != null;

  // Function to update payment method if different from current method
  Future<bool> updatePaymentMethodIfDifferent(
      PaymentMethod selectedMethod, BuildContext context) async {
    try {
      // Only call API if the selected method is different from current method
      if (ongoingBooking?.payment?.paymentMethod != selectedMethod) {
        final paymentId = ongoingBooking?.payment?.id;
        if (paymentId != null) {
          final updateReq = UpdatePaymentReq(paymentMethod: selectedMethod);
          final result =
              await paymentRepository.updatePaymentMethod(paymentId, updateReq);

          if (result.errorKey != null) {
            throw Exception(result.errorKey);
          }

          // Refetch booking data after successful payment method update
          final bookingId = ongoingBooking?.id;
          if (bookingId != null) {
            await _refetchBookingData(bookingId);
          }
        }
      }
      return true;
    } catch (error) {
      log("Error updating payment method: $error");
      showDialog(
        context: context,
        builder: (errorContext) => AlertDialogCommon(
          title: appFonts.errorOccur,
          image: eGifAssets.error,
          subtext: language(context, error.toString()),
          height: Sizes.s145,
          bText1: appFonts.okay,
          b1OnTap: () => route.pop(errorContext),
        ),
      );
      return false;
    }
  }

  // Helper function to refetch booking data
  Future<void> _refetchBookingData(String bookingId) async {
    try {
      final bookings = await bookingRepository.getBookingByIdBooking(bookingId);
      if (bookings.isNotEmpty) {
        ongoingBooking = bookings.first;
        notifyListeners();
      }
    } catch (error) {
      log("Error refetching booking data: $error");
      // Silently fail as this is just for data refresh
    }
  }

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
          ongoingBooking = value.first;
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

  Future<void> openChat(BuildContext context) async {
    if (ongoingBooking?.id != null) {
      route.pushNamed(context, routeName.chat, arg: ongoingBooking!.id);
    }
  }

  showBookingStatus(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return BookingStatusDialog(bookingId: ongoingBooking?.id);
      },
    );
  }

  onStartServicePass(context) {
    // Get booking ID from the model
    String? bookingId = ongoingBooking?.id;

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
    String? bookingId = ongoingBooking?.id;
    if (bookingId != null) {
      // Show payment method selection bottom sheet
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => ChangePaymentMethodSheet(
          initialMethod: ongoingBooking?.payment?.paymentMethod,
          onContinue: (selectedMethod, bottomSheetContext) async {
            // Update payment method first if different from current method
            final success = await updatePaymentMethodIfDifferent(
                selectedMethod, bottomSheetContext);

            if (!success) {
              return; // Cancel the whole process if payment method update fails
            }

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
                        if (ongoingBooking?.payment != null) {
                          ongoingBooking = ongoingBooking?.copyWith(
                              payment: ongoingBooking?.payment?.copyWith(
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
              if (ongoingBooking?.payment?.id != null) {
                route.pushNamed(bottomSheetContext, routeName.paymentQr,
                    arg: ongoingBooking!.payment!.id);
              }
            }
          },
        ),
      );
    }
  }

  void navigateToPaymentQr(BuildContext context) {
    // First check if we have a valid booking model
    if (ongoingBooking == null) {
      return;
    }

    // Then check if we have a payment
    if (ongoingBooking?.payment == null) {
      return;
    }

    // Finally check if we have a payment ID
    final paymentId = ongoingBooking?.payment?.id;
    if (paymentId == null || paymentId.isEmpty) {
      return;
    }

    if (ongoingBooking?.payment?.paymentQr != null) {
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
                    .cancelBooking(ongoingBooking!.id!, reasonCtrl.text)
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
