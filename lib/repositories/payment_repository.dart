import 'package:salon_provider/common/enum_value.dart';
import 'package:salon_provider/config/auth_config.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/config/repository_config.dart';
import 'package:salon_provider/model/request/generate_qr_req.dart';
import 'package:salon_provider/model/request/payment_req.dart';
import 'package:salon_provider/model/request/search_request_model.dart';
import 'package:salon_provider/model/response/bank_account_res.dart';
import 'package:salon_provider/model/response/bank_res.dart';
import 'package:salon_provider/model/response/common_response.dart';
import 'package:salon_provider/model/response/payment_response.dart';
import 'package:salon_provider/network/api.dart';

class PaymentRepository extends RepositoryConfig {
  final paymentClient = getIt<PaymentApiClient>();

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
    var userId = await AuthConfig.getUserId();

    var defaultCondition = Condition(
      source: "booking.service_man_id",
      operator: "=",
      target: userId,
    );

    if (conditions != null && conditions[0].isEmpty) {
      conditions[0].add(defaultCondition);
    }

    var requestBody = SearchRequestBody(
      model: EnumColumn.payment.name,
      conditions: conditions ??
          [
            [defaultCondition]
          ],
      fields: [
        FieldItem(field: "booking.user.user_profile.profile_picture_url"),
        FieldItem(field: "booking.service_versions"),
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
    var payments =
        (response as List<dynamic>).map((e) => Payment.fromJson(e)).toList();

    return payments;
  }

  Future<String> genPaymentQrCode(GenerateQRReq requestBody) async {
    var res = await paymentClient.genPaymentQrCode(requestBody);
    if (res.errorKey != null) {
      throw Exception(res.errorKey);
    }
    return res.data!;
  }

  Future<List<Bank>> getBanks() async {
    var res = await paymentClient.getBanks();
    return res.data ?? [];
  }

  Future<List<BankAccountRes>> getBankAccounts() async {
    var requestBody = SearchRequestBody(
      model: EnumColumn.bank_account.name,
      conditions: [
        [
          Condition(source: "status", operator: "=", target: "active"),
        ]
      ],
      fields: [
        FieldItem(field: "bank_name"),
        FieldItem(field: "bank_code"),
        FieldItem(field: "bank_bin"),
        FieldItem(field: "bank_short_name"),
        FieldItem(field: "bank_logo"),
        FieldItem(field: "account_name"),
        FieldItem(field: "account_number"),
        FieldItem(field: "swift_code"),
        FieldItem(field: "is_default"),
      ],
      orderBy: "id desc",
    );

    final response = await commonRestClient
        .search<List<BankAccountRes>>(requestBody.toJson());
    var res = (response as List<dynamic>)
        .map((e) => BankAccountRes.fromJson(e))
        .toList();
    return res;
  }

  Future<BaseResponse<bool>> updatePaymentMethod(
      String id, UpdatePaymentReq requestBody) async {
    var res = await paymentClient.updatePayment(id, requestBody);
    return res;
  }
}
