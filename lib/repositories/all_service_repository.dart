import 'package:salon_provider/common/enum_value.dart';
import 'package:salon_provider/config/auth_config.dart';
import 'package:salon_provider/config/repository_config.dart';
import 'package:salon_provider/model/request/search_request_model.dart';
import 'package:salon_provider/model/response/service_response.dart';

class AllServiceRepository extends RepositoryConfig {
  Future<List<Service>> getAllServices(SearchRequestBody searchBody) async {
    String? userId = await AuthConfig.getUserId();

    // Add owner_id condition to existing conditions
    final List<List<Condition>> conditions = [
      [
        Condition(source: "owner_id", operator: "=", target: userId ?? ''),
        if (searchBody.conditions.isNotEmpty) ...searchBody.conditions[0],
      ],
      if (searchBody.conditions.length > 1) ...searchBody.conditions.sublist(1),
    ];

    final requestBody = searchBody.copyWith(
      conditions: conditions,
      fields: [
        ...searchBody.fields,
        FieldItem(field: "versions"),
        FieldItem(field: "service_version.main_image"),
        FieldItem(field: "service_version.images"),
        FieldItem(field: "service_version.category"),
        FieldItem(field: "images"),
        FieldItem(field: "service_version")
      ],
    );

    var response =
        await commonRestClient.search<List<Service>>(requestBody.toJson());
    var res =
        (response as List<dynamic>).map((e) => Service.fromJson(e)).toList();
    return res;
  }

  Future<Service> getServiceById(String id) async {
    var response = await commonRestClient.search<Service>(
        SearchRequestBody(model: EnumColumn.service.name, conditions: [
      [
        Condition(source: "id", operator: "=", target: id),
      ]
    ], fields: [
      FieldItem(field: "versions.images"),
      FieldItem(field: "versions.main_image"),
      FieldItem(field: "service_version.main_image"),
      FieldItem(field: "service_version.images"),
      FieldItem(field: "service_version.category"),
      FieldItem(field: "images"),
      FieldItem(field: "service_version")
    ]).toJson());
    var res = Service.fromJson(response);
    return res;
  }
}
