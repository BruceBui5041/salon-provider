import 'package:salon_provider/common/enum_value.dart';
import 'package:salon_provider/config/repository_config.dart';
import 'package:salon_provider/model/request/search_request_model.dart';
import 'package:salon_provider/model/response/payment_response.dart';

class PaymentRepository extends RepositoryConfig {
  Future<Payment> getPaymentById(String paymentId) async {
    var body = SearchRequestBody(model: EnumColumn.payment.name, conditions: [
      [
        Condition(source: "id", operator: "=", target: paymentId),
      ]
    ], fields: [
      FieldItem(field: "payment_qr"),
    ]);
    var response = await commonRestClient.search<Payment>(body.toJson());
    var res = Payment.fromJson(response);
    return res;
  }

  Future<List<Payment>> getPayments({
    List<List<Condition>>? conditions,
    int? limit,
    int? offset,
  }) async {
    var requestBody = SearchRequestBody(
      model: EnumColumn.payment.name,
      conditions: conditions ?? [],
      fields: [
        FieldItem(field: "user.user_profile.profile_picture_url"),
        FieldItem(field: "payment_qr"),
        FieldItem(field: "booking.service_versions"),
        FieldItem(field: "user_id"),
        FieldItem(field: "amount"),
        FieldItem(field: "currency"),
        FieldItem(field: "payment_method"),
        FieldItem(field: "transaction_id"),
        FieldItem(field: "transaction_status"),
      ],
      orderBy: "id desc",
      limit: limit,
      offset: offset,
    );
    final response =
        await commonRestClient.search<List<Payment>>(requestBody.toJson());
    var res =
        (response as List<dynamic>).map((e) => Payment.fromJson(e)).toList();
    return res;
  }
}
