import 'package:salon_provider/common/enum_value.dart';
import 'package:salon_provider/config/auth_config.dart';
import 'package:salon_provider/config/repository_config.dart';
import 'package:salon_provider/model/request/search_request_model.dart';
import 'package:salon_provider/model/response/service_response.dart';

class AllServiceRepository extends RepositoryConfig {
  Future<List<ItemService>> getAllServices() async {
    String? userId = await AuthConfig.getUserId();
    var response = await commonRestClient.search<List<ItemService>>(
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
    var res = (response as List<dynamic>)
        .map((e) => ItemService.fromJson(e))
        .toList();
    return res;
  }

  Future<ItemService> getServiceById(String id) async {
    String? userId = await AuthConfig.getUserId();
    var response = await commonRestClient.search<ItemService>(
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
    var res = ItemService.fromJson(response);
    return res;
  }
}
