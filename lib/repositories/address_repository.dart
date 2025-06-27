import 'package:salon_provider/model/request/address_req.dart';
import 'package:salon_provider/model/response/address_res.dart';
import 'package:salon_provider/model/response/common_response.dart';
import 'package:salon_provider/network/address_api.dart';
import 'package:salon_provider/config/repository_config.dart';
import 'package:salon_provider/model/request/search_request_model.dart';
import 'package:salon_provider/config/auth_config.dart';

class AddressRepository extends RepositoryConfig {
  final AddressApi _addressApi;

  AddressRepository(this._addressApi);

  Future<BaseResponse<Address>> createAddress(dynamic requestBody) async {
    return await _addressApi.createAddress(requestBody);
  }

  Future<BaseResponse<Address>> updateAddress(
      String id, dynamic requestBody) async {
    return await _addressApi.updateAddress(id, requestBody);
  }

  Future<BaseResponse<dynamic>> deleteAddress(String id) async {
    return await _addressApi.deleteAddress(id);
  }

  Future<BaseResponse<bool>> chooseCurrentAddress(
      ChooseCurrentAddressReq requestBody) async {
    return await _addressApi.chooseCurrentAddress(requestBody);
  }

  Future<Address?> getCurrentAddress() async {
    var userId = await AuthConfig.getUserId();

    var requestBody = SearchRequestBody(
      model: "address",
      conditions: [
        [
          Condition(source: "user_id", operator: "=", target: userId),
          Condition(source: "status", operator: "=", target: "active"),
          Condition(source: "type", operator: "=", target: "current"),
        ]
      ],
      fields: [
        FieldItem(field: "type"),
        FieldItem(field: "default"),
        FieldItem(field: "text"),
        FieldItem(field: "latitude"),
        FieldItem(field: "longitude"),
        FieldItem(field: "user"),
      ],
      limit: 1,
    );

    final response =
        await commonRestClient.search<List<Address>>(requestBody.toJson());
    var addresses =
        (response as List<dynamic>).map((e) => Address.fromJson(e)).toList();

    return addresses.isNotEmpty ? addresses.first : null;
  }
}
