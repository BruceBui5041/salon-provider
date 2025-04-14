import 'package:salon_provider/common/enum_value.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/config/repository_config.dart';
import 'package:salon_provider/model/request/cancel_req.dart';
import 'package:salon_provider/model/request/search_request_model.dart';
import 'package:salon_provider/model/response/booking_response.dart';
import 'package:salon_provider/model/response/category_response.dart';
import 'package:salon_provider/model/response/gen_qr_response.dart';
import 'package:salon_provider/model/response/payment_qr_transaction.dart';
import 'package:salon_provider/network/api.dart';

class BookingRepository extends RepositoryConfig {
  final paymentClient = getIt.get<PaymentApiClient>();
  final bookingClient = getIt.get<BookingApiClient>();

  Future<List<Booking>> getBookingByIdBooking(String bookingId) async {
    var body = SearchRequestBody(model: "booking", conditions: [
      [
        Condition(source: "id", operator: "=", target: bookingId),
      ]
    ], fields: [
      FieldItem(field: "service_versions"),
      FieldItem(field: "user.user_profile"),
      FieldItem(field: "service_versions.main_image"),
      FieldItem(field: "payment.payment_qr"),
      FieldItem(field: "service_man"),
      FieldItem(field: "service_versions.category"),
      FieldItem(field: "coupon"),
      FieldItem(field: "commission"),
    ]);
    var response = await commonRestClient.search<List<Booking>>(body.toJson());
    var res =
        (response as List<dynamic>).map((e) => Booking.fromJson(e)).toList();
    return res;
  }

  Future<GenQrResponse> getGenQrCode(Map<String, dynamic> requestBody) async {
    var res = await paymentClient.getGenQrCode(requestBody);
    return res;
  }

  Future<List<ItemPaymentQrTransaction>> getPaymentByIdPayment(
      String paymentId) async {
    var body = SearchRequestBody(model: "payment", conditions: [
      [
        Condition(source: "id", operator: "=", target: paymentId),
      ]
    ], fields: [
      FieldItem(field: "payment_qr"),
    ]);
    var response = await commonRestClient
        .search<List<ItemPaymentQrTransaction>>(body.toJson());
    var res = (response as List<dynamic>)
        .map((e) => ItemPaymentQrTransaction.fromJson(e))
        .toList();
    return res;
  }

  Future<List<Booking>> getBookings({
    List<List<Condition>>? conditions,
    int? limit,
    int? offset,
  }) async {
    var requestBody = SearchRequestBody(
      model: EnumColumn.booking.name,
      conditions: conditions ?? [],
      fields: [
        FieldItem(field: "service_versions"),
        FieldItem(field: "user"),
        FieldItem(field: "service_versions.main_image"),
        FieldItem(field: "payment.payment_qr"),
        FieldItem(field: "service_man"),
        FieldItem(field: "service_versions.category"),
        FieldItem(field: "coupon"),
        FieldItem(field: "commission"),
      ],
      orderBy: "id desc",
      limit: limit,
      offset: offset,
    );
    final response =
        await commonRestClient.search<List<Booking>>(requestBody.toJson());
    var res =
        (response as List<dynamic>).map((e) => Booking.fromJson(e)).toList();
    return res;
  }

  Future<List<CategoryItem>> getCategories({
    List<List<Condition>>? conditions,
  }) async {
    var requestBody = SearchRequestBody(
      model: EnumColumn.category.name,
      conditions: conditions ?? [],
      fields: [
        FieldItem(field: "id"),
        FieldItem(field: "name"),
      ],
    );
    final response =
        await commonRestClient.search<List<CategoryItem>>(requestBody.toJson());
    var res = (response as List<dynamic>)
        .map((e) => CategoryItem.fromJson(e))
        .toList();
    return res;
  }

  Future<bool> cancelBooking(String bookingId, String reason) async {
    var body = CancelReq(cancellationReason: reason);

    var response = await bookingClient.cancelBooking(bookingId, body);
    return response.data ?? false;
  }

  Future<bool> acceptBooking(String bookingId) async {
    var response = await bookingClient.acceptBooking(bookingId);
    return response.data ?? false;
  }

  // Future<void> updateBooking(Booking booking) async {}

  // Future<void> deleteBooking(String bookingId) async {}

  // Future<void> addBooking(Booking booking) async {
  //   //
  // }
}
