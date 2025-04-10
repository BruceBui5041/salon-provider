import 'package:dio/dio.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/config/repository_config.dart';
import 'package:salon_provider/network/api.dart';

class EditServiceRepository extends RepositoryConfig {
  final api = getIt.get<ServiceApiClient>();

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

  Future<void> updateService(String serviceId, FormData formData) async {
    await api.updateCraftService(serviceId, formData);
  }

  // Future<void> getAllServiceVersions(String serviceId) async {
  //   var body = SearchRequestBody(model: EnumColumn.service.name, conditions: [
  //     [
  //       Condition(source: "id", operator: "=", target: serviceId),
  //     ]
  //   ], fields: []);
  //   await commonRestClient.search(body.toJson());
  // }
}
