import 'package:fixit_provider/common/enum_value.dart';
import 'package:fixit_provider/config/repository_config.dart';
import 'package:fixit_provider/model/request/search_request_model.dart';
import 'package:fixit_provider/model/response/service_response.dart';

class PopularServiceRepository extends RepositoryConfig {
  Future<ServiceResponse> getPopularService() async {
    var body = SearchRequestBody(model: EnumColumn.service.name, conditions: [
      [
        Condition(
            source: "creator_id", operator: "=", target: "43b6gxdUavHP56"),
      ]
    ], fields: []);
    return await commonRestClient.search(
        ServiceResponse.fromJson, body.toJson());
  }
}
