import 'package:dio/dio.dart';
import 'package:salon_provider/config/repository_config.dart';
import 'package:salon_provider/model/request/search_request_model.dart';
import 'package:salon_provider/model/response/category_response.dart';
import 'package:salon_provider/model/response/service_version_response.dart';

class AddNewServiceRepository extends RepositoryConfig {
  Future<dynamic> createService(FormData formData) async {
    return await api.createService(formData);
  }

  Future<void> createCraft(String serviceId) async {
    await api.createServiceCraft({
      "service_id": serviceId,
    });
  }

  Future<CategoryResponse> fetchCategories() async {
    return await commonRestClient.search<CategoryResponse>(
        CategoryResponse.fromJson,
        SearchRequestBody(model: "category", conditions: [
          [Condition(source: "status", operator: "=", target: "active")]
        ], fields: [
          FieldItem(field: "parent"),
          FieldItem(field: "sub_categories"),
        ]).toJson());
  }

  Future<void> publisthService(
      String serviceId, String serviceVersionId) async {
    await api.publishService(serviceId, {
      "service_version_id": serviceVersionId,
      "id": serviceId,
    });
  }

  Future<CategoryResponse> fetchSubCategories(String id) async {
    return await commonRestClient.search<CategoryResponse>(
        CategoryResponse.fromJson,
        SearchRequestBody(model: "category", conditions: [
          [
            Condition(source: "status", operator: "=", target: "active"),
            Condition(source: "id", operator: "=", target: id)
          ]
        ], fields: [
          FieldItem(field: "parent"),
          FieldItem(field: "sub_categories"),
        ]).toJson());
  }

  Future<ServiceVersionCommonResponse> fetchServiceVersion(String id) async {
    var res = await commonRestClient.search<ServiceVersionCommonResponse>(
        ServiceVersionCommonResponse.fromJson,
        SearchRequestBody(model: "service_version", conditions: [
          [
            Condition(source: "id", operator: "=", target: id),
          ]
        ], fields: [
          FieldItem(field: "service"),
        ]).toJson());
    return res;
  }
}
