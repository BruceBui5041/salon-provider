import 'package:fixit_provider/config.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/booking_details_model.dart';

class BookingDetailsProvider with ChangeNotifier {

  BookingDetailsModel? bookingModel;

  onReady() {
    bookingModel = BookingDetailsModel.fromJson(appArray.bookingDetailsList);
    notifyListeners();
  }

  Future<void> makePhoneCall(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }}

  onTapPhone(){
    makePhoneCall(Uri.parse('tel:+91 8200798552'));
    notifyListeners();
  }


}