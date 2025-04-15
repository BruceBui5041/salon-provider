import 'dart:developer';

import 'package:salon_provider/config.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/model/response/booking_response.dart';
import 'package:salon_provider/repositories/booking_repository.dart';
import 'package:salon_provider/common/payment_method.dart';
import 'package:salon_provider/common/transaction_status.dart';

class OngoingBookingProvider with ChangeNotifier {
  Booking? ongoingBookingModel;
  String? amount;
  bool isServicemen = false;
  TextEditingController reasonCtrl = TextEditingController();
  final BookingRepository bookingRepository = getIt<BookingRepository>();

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
          return BookingStatusDialog();
        });
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
  markPaymentCompleted(context) {
    String? bookingId = ongoingBookingModel?.id;
    if (bookingId != null) {
      // Implementation of payment completion API call would go here
      // For now, just updating the local model and navigating
      if (ongoingBookingModel?.payment != null) {
        ongoingBookingModel = ongoingBookingModel?.copyWith(
            payment: ongoingBookingModel?.payment
                ?.copyWith(transactionStatus: TransactionStatus.completed));
        notifyListeners();
      }
    }
  }
}
