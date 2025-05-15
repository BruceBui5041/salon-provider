import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/model/response/booking_response.dart';
import 'package:salon_provider/repositories/booking_repository.dart';
import '../../config.dart';

class PendingBookingProvider with ChangeNotifier {
  Booking? pendingBooking;
  final BookingRepository bookingRepository = getIt<BookingRepository>();

  TextEditingController reasonCtrl = TextEditingController();
  TextEditingController amountCtrl = TextEditingController();
  FocusNode reasonFocus = FocusNode();
  FocusNode amountFocus = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> amountFormKey = GlobalKey<FormState>();

  bool isServicemen = false, isAmount = false;

  onReady(context) {
    String bookingId = ModalRoute.of(context)!.settings.arguments as String;
    bookingRepository.getBookingByIdBooking(bookingId).then((value) {
      pendingBooking = value.first;
      notifyListeners();
    });
  }

  showBookingStatus(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return BookingStatusDialog(bookingId: pendingBooking?.id);
      },
    );
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
                    .cancelBooking(pendingBooking!.id!, reasonCtrl.text)
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

  onAcceptBooking(context) {
    notifyListeners();
    showDialog(
      context: context,
      builder: (context1) => AppAlertDialogCommon(
        height: Sizes.s100,
        title: appFonts.assignBooking,
        firstBText: appFonts.doItLater,
        secondBText: appFonts.yes,
        image: eGifAssets.dateGif,
        subtext: appFonts.doYouWantToAccept,
        firstBTap: () => route.pop(context),
        secondBTap: () {
          route.pop(context);
          bookingRepository.acceptBooking(pendingBooking!.id!).then((value) {
            if (value) {
              route.popAndPushNamed(context, routeName.assignBooking);
            }
          });
        },
      ),
    );
  }
}
