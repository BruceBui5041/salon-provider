import 'package:salon_provider/config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/model/response/booking_response.dart';
import 'package:salon_provider/repositories/booking_repository.dart';

class BookingDetailsProvider with ChangeNotifier {
  Booking? bookingModel;
  final BookingRepository bookingRepository = getIt<BookingRepository>();

  onReady(BuildContext context) async {
    String bookingId = ModalRoute.of(context)!.settings.arguments as String;
    await bookingRepository.getBookingByIdBooking(bookingId).then((value) {
      bookingModel = value.first;
      notifyListeners();
    });
  }

  Future<void> makePhoneCall(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  onTapPhone() {
    if (bookingModel?.user?.phoneNumber != null) {
      makePhoneCall(Uri.parse('tel:${bookingModel!.user!.phoneNumber}'));
    }
    notifyListeners();
  }
}
