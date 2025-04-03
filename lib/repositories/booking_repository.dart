import 'package:salon_provider/common/enum_value.dart';
import 'package:salon_provider/config/auth_config.dart';
import 'package:salon_provider/config/repository_config.dart';
import 'package:salon_provider/model/request/search_request_model.dart';
import 'package:salon_provider/model/response/booking_response.dart';
import 'package:salon_provider/model/response/gen_qr_response.dart';
import 'package:salon_provider/model/response/payment_qr_transaction.dart';
import 'package:salon_provider/model/response/service_version_response.dart';

class BookingRepository extends RepositoryConfig {
  // Future<BookingReso> getBookingDetails(String bookingId) async {
  //   return await bookingProvider.getBookingDetails(bookingId);
  // }
  Future<BookingResponse> getBookingByIdBooking(String bookingId) async {
    var body = SearchRequestBody(model: "booking", conditions: [
      [
        Condition(source: "id", operator: "=", target: bookingId),
      ]
    ], fields: [
      FieldItem(field: "payment.payment_qr"),
    ]);
    var res =
        await commonRestClient.search(BookingResponse.fromJson, body.toJson());
    return res;
  }

  Future<GenQrResponse> getGenQrCode(Map<String, dynamic> requestBody) async {
    var res = await api.getGenQrCode(requestBody);
    return res;
  }

  Future<PaymentTransactionResponse> getPaymentByIdPayment(
      String paymentId) async {
    var body = SearchRequestBody(model: "payment", conditions: [
      [
        Condition(source: "id", operator: "=", target: paymentId),
      ]
    ], fields: [
      FieldItem(field: "payment_qr"),
    ]);
    var res = await commonRestClient.search(
        PaymentTransactionResponse.fromJson, body.toJson());
    return res;
  }

  Future<BookingResponse> getBookings() async {
    var userId = await AuthConfig.getUserId();
    var requestBody = SearchRequestBody(
        model: EnumColumn.booking.name,
        conditions: [
          [
            Condition(
              source: "service_man_id",
              operator: "=",
              target: userId ?? "",
            ),
          ]
        ],
        fields: [
          FieldItem(field: "service_versions"),
          FieldItem(field: "service_versions.main_image"),
          FieldItem(field: "payment.payment_qr"),
          FieldItem(field: "service_man"),
          FieldItem(field: "service_versions.category"),
        ],
        orderBy: "id desc");
    final response = await commonRestClient.search(
        BookingResponse.fromJson, requestBody.toJson());
    return response;
  }

  // Future<void> updateBooking(Booking booking) async {}

  // Future<void> deleteBooking(String bookingId) async {}

  // Future<void> addBooking(Booking booking) async {
  //   //
  // }
}
