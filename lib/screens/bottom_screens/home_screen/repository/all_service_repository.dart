import 'package:fixit_provider/common/enum_value.dart';
import 'package:fixit_provider/config/auth_config.dart';
import 'package:fixit_provider/config/repository_config.dart';
import 'package:fixit_provider/model/request/search_request_model.dart';
import 'package:fixit_provider/model/response/service_response.dart';

class AllServiceRepository extends RepositoryConfig {
  Future<ServiceResponse> getAllServices() async {
    String? userId = await AuthConfig.getUserId();
    var res = await commonRestClient.search<ServiceResponse>(
        ServiceResponse.fromJson,
        SearchRequestBody(model: EnumColumn.service.name, conditions: [
          [Condition(source: "creator_id", operator: "=", target: userId ?? '')]
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
