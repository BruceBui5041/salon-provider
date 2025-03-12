import 'package:fixit_provider/common/enum_value.dart';
import 'package:fixit_provider/config/repository_config.dart';
import 'package:fixit_provider/model/request/search_request_model.dart';
import 'package:fixit_provider/model/response/booking_response.dart';
import 'package:fixit_provider/model/response/service_version_response.dart';

class BookingRepository extends RepositoryConfig {
  // Future<BookingReso> getBookingDetails(String bookingId) async {
  //   return await bookingProvider.getBookingDetails(bookingId);
  // }

  Future<BookingResponse> getBookings() async {
    var res = await commonRestClient.search<BookingResponse>(
        BookingResponse.fromJson,
        SearchRequestBody(model: EnumColumn.booking.name, conditions: [
          [
            Condition(
                source: "user_id", operator: "=", target: "43b6gxdUavHP56")
          ]
        ], fields: [
          FieldItem(field: "service_versions")
        ]).toJson());
    return res;
  }

  // Future<void> updateBooking(Booking booking) async {}

  // Future<void> deleteBooking(String bookingId) async {}

  // Future<void> addBooking(Booking booking) async {
  //   //
  // }
}
