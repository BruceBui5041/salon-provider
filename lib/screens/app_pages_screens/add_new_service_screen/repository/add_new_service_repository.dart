import 'package:dio/dio.dart';
import 'package:fixit_provider/config/repository_config.dart';
import 'package:fixit_provider/model/request/search_request_model.dart';
import 'package:fixit_provider/model/response/category_response.dart';

class AddNewServiceRepository extends RepositoryConfig {
  Future<dynamic> createService(FormData formData) async {
    return await api.createService(formData);
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
}
