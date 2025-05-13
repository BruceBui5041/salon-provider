import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/model/request/search_request_model.dart';
import 'package:salon_provider/model/response/service_response.dart';
import 'package:salon_provider/repositories/all_service_repository.dart';
import 'package:flutter/material.dart';

class AllServiceProvider extends ChangeNotifier {
  List<Service> serviceResponse = [];
  bool isLoading = false;
  bool hasMoreData = true;
  int currentOffset = 0;
  int pageSize = 5;

  var repo = getIt.get<AllServiceRepository>();

  void resetPagination() {
    serviceResponse = [];
    currentOffset = 0;
    hasMoreData = true;
    notifyListeners();
  }

  Future<List<Service>> fetchPage(int offset,
      {int? limit, String? orderBy}) async {
    final searchBody = SearchRequestBody(
      model: "service",
      conditions: [],
      fields: [
        FieldItem(field: "id"),
        FieldItem(field: "status"),
        FieldItem(field: "service_version"),
        FieldItem(field: "image"),
      ],
      limit: limit ?? pageSize,
      offset: offset,
      orderBy: orderBy ?? "id desc",
    );

    try {
      isLoading = true;
      notifyListeners();

      List<Service> fetchedServices = await repo.getAllServices(searchBody);

      // Update pagination state
      if (offset == 0) {
        // First page - reset list
        serviceResponse = fetchedServices;
      } else {
        // Append to existing list
        serviceResponse.addAll(fetchedServices);
      }

      hasMoreData = fetchedServices.length >= (limit ?? pageSize);
      currentOffset = hasMoreData ? offset + fetchedServices.length : offset;

      return fetchedServices;
    } catch (e) {
      return [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Keep the original method for backward compatibility
  Future<void> getAllServices({
    List<List<Condition>>? conditions,
    int? limit,
    int? offset,
    String? orderBy,
    bool loadMore = false,
  }) async {
    if (isLoading || (!loadMore && !hasMoreData)) return;

    if (!loadMore) {
      resetPagination();
    }

    await fetchPage(offset ?? currentOffset, limit: limit, orderBy: orderBy);
  }
}
