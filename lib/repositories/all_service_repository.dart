import 'package:salon_provider/common/enum_value.dart';
import 'package:salon_provider/config/auth_config.dart';
import 'package:salon_provider/config/repository_config.dart';
import 'package:salon_provider/model/request/search_request_model.dart';
import 'package:salon_provider/model/response/service_response.dart';

class AllServiceRepository extends RepositoryConfig {
  Future<ServiceResponse> getAllServices() async {
    String? userId = await AuthConfig.getUserId();
    var res = await commonRestClient.search<ServiceResponse>(
        ServiceResponse.fromJson,
        SearchRequestBody(model: EnumColumn.service.name, conditions: [
          [
            Condition(source: "owner_id", operator: "=", target: userId ?? ''),
          ]
        ], fields: [
          FieldItem(field: "versions"),
          FieldItem(field: "service_version.main_image"),
          FieldItem(field: "service_version.images"),
          FieldItem(field: "service_version.category"),
          FieldItem(field: "images"),
          FieldItem(field: "service_version")
        ]).toJson());
    return res;
  }

  Future<ServiceResponse> getServiceById(String id) async {
    String? userId = await AuthConfig.getUserId();
    var res = await commonRestClient.search<ServiceResponse>(
        ServiceResponse.fromJson,
        SearchRequestBody(model: EnumColumn.service.name, conditions: [
          // [
          //   Condition(source: "owner_id", operator: "=", target: userId ?? ''),
          // ],
          [
            Condition(source: "id", operator: "=", target: id),
          ]
        ], fields: [
          FieldItem(field: "versions"),
          FieldItem(field: "service_version.main_image"),
          FieldItem(field: "service_version.images"),
          FieldItem(field: "service_version.category"),
          FieldItem(field: "images"),
          FieldItem(field: "service_version")
        ]).toJson());
    return res;
  }
}
