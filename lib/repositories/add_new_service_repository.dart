import 'package:dio/dio.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/config/repository_config.dart';
import 'package:salon_provider/model/request/search_request_model.dart';
import 'package:salon_provider/model/response/category_response.dart';
import 'package:salon_provider/model/response/service_version_response.dart';
import 'package:salon_provider/network/api.dart';

class AddNewServiceRepository extends RepositoryConfig {
  final api = getIt.get<ServiceApiClient>();

  Future<dynamic> createService(FormData formData) async {
    return await api.createService(formData);
  }

  Future<void> createCraft(String serviceId) async {
    await api.createServiceCraft({
      "service_id": serviceId,
    });
  }

  Future<List<CategoryItem>> fetchCategories() async {
    var response = await commonRestClient.search<List<CategoryItem>>(
        SearchRequestBody(model: "category", conditions: [
      [Condition(source: "status", operator: "=", target: "active")]
    ], fields: [
      FieldItem(field: "parent"),
      FieldItem(field: "sub_categories"),
    ]).toJson());
    var res = (response as List<dynamic>)
        .map((e) => CategoryItem.fromJson(e))
        .toList();
    return res;
  }

  Future<void> publisthService(
      String serviceId, String serviceVersionId) async {
    await api.publishService(serviceId, {
      "service_version_id": serviceVersionId,
      "id": serviceId,
    });
  }

  Future<List<CategoryItem>> fetchSubCategories(String id) async {
    var response = await commonRestClient.search<List<CategoryItem>>(
        SearchRequestBody(model: "category", conditions: [
      [
        Condition(source: "status", operator: "=", target: "active"),
        Condition(source: "id", operator: "=", target: id)
      ]
    ], fields: [
      FieldItem(field: "parent"),
      FieldItem(field: "sub_categories"),
    ]).toJson());
    var res = (response as List<dynamic>)
        .map((e) => CategoryItem.fromJson(e))
        .toList();
    return res;
  }

  Future<ServiceVersion> fetchServiceVersion(String id) async {
    var response = await commonRestClient.search<ServiceVersion>(
        SearchRequestBody(model: "service_version", conditions: [
      [
        Condition(source: "id", operator: "=", target: id),
      ]
    ], fields: [
      FieldItem(field: "service"),
      FieldItem(field: "category"),
      FieldItem(field: "images"),
      FieldItem(field: "main_image"),
    ]).toJson());
    var res = ServiceVersion.fromJson(response);
    return res;
  }
}
