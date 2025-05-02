import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/model/request/search_request_model.dart';
import 'package:salon_provider/model/response/service_response.dart';
import 'package:salon_provider/repositories/all_service_repository.dart';
import 'package:flutter/material.dart';

class AllServiceProvider extends ChangeNotifier {
  List<Service>? serviceResponse;

  var repo = getIt.get<AllServiceRepository>();

  Future<void> getAllServices({
    List<List<Condition>>? conditions,
    int? limit,
    int? offset,
    String? orderBy,
  }) async {
    final searchBody = SearchRequestBody(
      model: "service",
      conditions: conditions ?? [],
      fields: [
        FieldItem(field: "id"),
        FieldItem(field: "status"),
        FieldItem(field: "service_version"),
        FieldItem(field: "image"),
      ],
      limit: limit,
      offset: offset,
      orderBy: orderBy,
    );

    var res = await repo.getAllServices(searchBody);
    serviceResponse = res;

    notifyListeners();
  }
}
