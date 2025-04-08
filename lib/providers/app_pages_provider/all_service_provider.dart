import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/model/response/service_response.dart';
import 'package:salon_provider/repositories/all_service_repository.dart';
import 'package:flutter/material.dart';

class AllServiceProvider extends ChangeNotifier {
  List<ItemService>? serviceResponse;

  var repo = getIt.get<AllServiceRepository>();

  Future<void> getAllServices() async {
    var res = await repo.getAllServices();
    if (res != null && res!.isNotEmpty) {
      serviceResponse = res;
    }

    notifyListeners();
  }
}
