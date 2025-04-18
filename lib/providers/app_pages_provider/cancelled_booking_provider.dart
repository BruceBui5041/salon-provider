import 'package:salon_provider/config.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/repositories/booking_repository.dart';
import '../../model/response/booking_response.dart';

class CancelledBookingProvider with ChangeNotifier {
  Booking? cancelledBooking;
  final BookingRepository bookingRepository = getIt<BookingRepository>();

  onReady(context) async {
    String bookingId = ModalRoute.of(context)!.settings.arguments as String;
    await bookingRepository.getBookingByIdBooking(bookingId).then((value) {
      cancelledBooking = value.first;
      notifyListeners();
    });
  }

  showBookingStatus(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return BookingStatusDialog(bookingId: cancelledBooking?.id);
      },
    );
  }
}
