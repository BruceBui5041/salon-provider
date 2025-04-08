import 'package:salon_provider/common/enum_value.dart';
import 'package:salon_provider/config/auth_config.dart';
import 'package:salon_provider/config/repository_config.dart';
import 'package:salon_provider/model/request/search_request_model.dart';
import 'package:salon_provider/model/response/service_response.dart';

class PopularServiceRepository extends RepositoryConfig {
  Future<ServiceResponse> getPopularService() async {
    var user = await AuthConfig.getUserId();
    var body = SearchRequestBody(model: EnumColumn.service.name, conditions: [
      [
        Condition(source: "creator_id", operator: "=", target: user ?? ''),
      ]
    ], fields: []);
    return await commonRestClient.search(
        ServiceResponse.fromJson, body.toJson());
  }
}
