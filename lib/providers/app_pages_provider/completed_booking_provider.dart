import 'package:salon_provider/config.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/repositories/booking_repository.dart';
import '../../model/response/booking_response.dart';

class CompletedBookingProvider with ChangeNotifier {
  Booking? completedBookingModel;
  final BookingRepository bookingRepository = getIt<BookingRepository>();

  TextEditingController reasonCtrl = TextEditingController();
  onReady(context) async {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args == null) {
      _showError(context);
      return;
    }

    try {
      final bookings =
          await bookingRepository.getBookingByIdBooking(args as String);
      if (bookings.isNotEmpty) {
        completedBookingModel = bookings.first;
        notifyListeners();
      } else {
        _showError(context);
      }
    } catch (e) {
      _showError(context);
    }
  }

  void _showError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(language(context, appFonts.errorOccur)),
        backgroundColor: appColor(context).appTheme.red,
      ),
    );
    Navigator.pop(context);
  }

  showBookingStatus(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return BookingStatusDialog();
        });
  }

  onCompleteBooking(context) {
    showDialog(
      context: context,
      builder: (context1) => AppAlertDialogCommon(
        height: Sizes.s100,
        title: appFonts.complete,
        firstBText: appFonts.cancel,
        secondBText: appFonts.yes,
        image: eGifAssets.dateGif,
        subtext: appFonts.areYouSureYourself,
        firstBTap: () => route.pop(context),
        secondBTap: () {
          route.pop(context);
          if (completedBookingModel?.id != null) {
            bookingRepository
                .completeBooking(completedBookingModel!.id!)
                .then((value) {
              if (value) {
                route.pushNamed(context, routeName.dashboard);
              }
            }).catchError((error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(language(context, appFonts.errorOccur)),
                  backgroundColor: appColor(context).appTheme.red,
                ),
              );
            });
          }
        },
      ),
    );
  }
}
