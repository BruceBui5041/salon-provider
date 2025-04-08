import 'package:salon_provider/common/enum_value.dart';
import 'package:salon_provider/config/repository_config.dart';
import 'package:salon_provider/model/request/search_request_model.dart';
import 'package:salon_provider/model/response/booking_response.dart';
import 'package:salon_provider/model/response/category_response.dart';
import 'package:salon_provider/model/response/common_response.dart';
import 'package:salon_provider/model/response/gen_qr_response.dart';
import 'package:salon_provider/model/response/payment_qr_transaction.dart';

class BookingRepository extends RepositoryConfig {
  // Future<BookingReso> getBookingDetails(String bookingId) async {
  //   return await bookingProvider.getBookingDetails(bookingId);
  // }
  Future<List<ItemBooking>> getBookingByIdBooking(String bookingId) async {
    var body = SearchRequestBody(model: "booking", conditions: [
      [
        Condition(source: "id", operator: "=", target: bookingId),
      ]
    ], fields: [
      FieldItem(field: "payment.payment_qr"),
    ]);
    var response =
        await commonRestClient.search<List<ItemBooking>>(body.toJson());
    var res = (response as List<dynamic>)
        .map((e) => ItemBooking.fromJson(e))
        .toList();
    return res;
  }

  Future<GenQrResponse> getGenQrCode(Map<String, dynamic> requestBody) async {
    var res = await api.getGenQrCode(requestBody);
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

  Future<List<ItemBooking>> getBookings({
    List<List<Condition>>? conditions,
    int? limit,
    int? offset,
  }) async {
    var requestBody = SearchRequestBody(
      model: EnumColumn.booking.name,
      conditions: conditions ?? [],
      fields: [
        FieldItem(field: "service_versions"),
        FieldItem(field: "service_versions.main_image"),
        FieldItem(field: "payment.payment_qr"),
        FieldItem(field: "service_man"),
        FieldItem(field: "service_versions.category"),
      ],
      orderBy: "id desc",
      limit: limit,
      offset: offset,
    );
    final response =
        await commonRestClient.search<List<ItemBooking>>(requestBody.toJson());
    var res = (response as List<dynamic>)
        .map((e) => ItemBooking.fromJson(e))
        .toList();
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

  // Future<void> updateBooking(Booking booking) async {}

  // Future<void> deleteBooking(String bookingId) async {}

  // Future<void> addBooking(Booking booking) async {
  //   //
  // }
}
