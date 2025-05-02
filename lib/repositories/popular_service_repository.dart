import 'package:salon_provider/common/enum_value.dart';
import 'package:salon_provider/config/auth_config.dart';
import 'package:salon_provider/config/repository_config.dart';
import 'package:salon_provider/model/request/search_request_model.dart';
import 'package:salon_provider/model/response/service_response.dart';

class PopularServiceRepository extends RepositoryConfig {
  Future<List<Service>> getPopularService() async {
    var user = await AuthConfig.getUserId();
    var response = await commonRestClient.search<List<Service>>(
        SearchRequestBody(model: EnumColumn.service.name, conditions: [
      [
        Condition(source: "creator_id", operator: "=", target: user ?? ''),
      ]
    ], fields: [
      FieldItem(field: "versions"),
      FieldItem(field: "service_version.main_image"),
      FieldItem(field: "service_version.images"),
      FieldItem(field: "service_version.category"),
      FieldItem(field: "images"),
    ]).toJson());
    var res =
        (response as List<dynamic>).map((e) => Service.fromJson(e)).toList();
    return res;
  }
}
