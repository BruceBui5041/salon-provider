import 'package:salon_provider/model/request/address_req.dart';
import 'package:salon_provider/model/response/address_res.dart';
import 'package:salon_provider/model/response/common_response.dart';
import 'package:salon_provider/network/address_api.dart';
import 'package:salon_provider/config/repository_config.dart';

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
}
