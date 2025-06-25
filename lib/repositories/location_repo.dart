import 'package:salon_provider/model/response/address_res.dart';
import 'package:salon_provider/network/location_api.dart';
import 'package:salon_provider/model/request/location_req.dart';
import 'package:salon_provider/model/response/common_response.dart';
import 'package:salon_provider/config/auth_config.dart';
import 'package:salon_provider/config/repository_config.dart';
import 'package:salon_provider/model/request/search_request_model.dart';

class LocationRepo extends RepositoryConfig {
  final LocationApi _locationApi;

  LocationRepo(this._locationApi);

  Future<BaseResponse<List<Address>>> reverseGeocode(
      ReverseGeocodeReq requestBody) async {
    return await _locationApi.reverseGeocode(requestBody);
  }

  Future<List<Address>> getRecentAddresses({int limit = 10}) async {
    var userId = await AuthConfig.getUserId();

    var requestBody = SearchRequestBody(
      model: "address",
      conditions: [
        [
          Condition(source: "user_id", operator: "=", target: userId),
          Condition(source: "status", operator: "=", target: "active"),
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
      orderBy: "id desc",
      limit: limit,
    );

    final response =
        await commonRestClient.search<List<Address>>(requestBody.toJson());
    var addresses =
        (response as List<dynamic>).map((e) => Address.fromJson(e)).toList();

    return addresses;
  }
}
