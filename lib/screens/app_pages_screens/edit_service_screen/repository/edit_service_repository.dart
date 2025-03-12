import 'package:fixit_provider/common/enum_value.dart';
import 'package:fixit_provider/config/repository_config.dart';
import 'package:fixit_provider/model/request/search_request_model.dart';
import 'package:fixit_provider/model/response/service_response.dart';

class EditServiceRepository extends RepositoryConfig {
  Future<void> publisthService(
      String serviceId, String serviceVersionId) async {
    await api.publishService(serviceId, {
      "service_version_id": serviceVersionId,
      "id": serviceId,
    });
  }

  Future<void> createCraft(String serviceId) async {
    await api.createServiceCraft({
      "service_id": serviceId,
    });
  }

  Future<void> getAllServiceVersions(String serviceId) async {
    var body = SearchRequestBody(model: EnumColumn.service.name, conditions: [
      [
        Condition(source: "id", operator: "=", target: serviceId),
      ]
    ], fields: []);
    await commonRestClient.search(ServiceResponse.fromJson, body.toJson());
  }
}
