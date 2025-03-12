import 'dart:developer';

import 'package:fixit_provider/config/injection_config.dart';
import 'package:fixit_provider/model/response/service_response.dart';
import 'package:fixit_provider/screens/bottom_screens/home_screen/repository/all_service_repository.dart';
import 'package:flutter/material.dart';

class AllServiceProvider extends ChangeNotifier {
  ServiceResponse? serviceResponse;

  var repo = getIt.get<AllServiceRepository>();

  Future<void> getAllServices() async {
    var res = await repo.getAllServices();
    if (res.data.isNotEmpty) {
      serviceResponse = res;
    }

    notifyListeners();
  }
}
