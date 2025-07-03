import 'package:flutter/material.dart';
import 'package:salon_provider/model/request/address_req.dart';
import 'package:salon_provider/model/request/location_req.dart';
import 'package:salon_provider/model/response/address_res.dart';
import 'package:salon_provider/repositories/address_repository.dart';
import 'package:salon_provider/repositories/location_repo.dart';

class AddressProvider extends ChangeNotifier {
  final AddressRepository _addressRepository;
  final LocationRepo _locationRepo;
  bool isLoading = false;
  String? errorMessage;

  AddressProvider(this._addressRepository, this._locationRepo);

  Future<void> chooseCurrentAddress({
    required Address address,
    required Function(bool) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      String? finalLatitude = address.latitude;
      String? finalLongitude = address.longitude;

      if (address.placeId != null && address.placeId != "") {
        final geocodeRequest = GeocodePlaceDetailReq(placeId: address.placeId);
        final geocodeResponse =
            await _locationRepo.geocodePlaceDetail(geocodeRequest);

        if (geocodeResponse.data != null) {
          finalLatitude = geocodeResponse.data!.latitude;
          finalLongitude = geocodeResponse.data!.longitude;
        } else {
          errorMessage =
              geocodeResponse.message ?? "Failed to get coordinates from place";
          onError(errorMessage!);
          return;
        }
      }

      final request = ChooseCurrentAddressReq(
        latitude: finalLatitude,
        longitude: finalLongitude,
        text: address.text,
      );

      if (address.id != null) {
        request.addressId = address.id;
      }

      final response = await _addressRepository.chooseCurrentAddress(request);

      if (response.data != null) {
        onSuccess(response.data ?? false);
      } else {
        errorMessage = response.message ?? "Failed to set current address";
        onError(errorMessage!);
      }
    } catch (e) {
      errorMessage = e.toString();
      onError(errorMessage!);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createAddress({
    required dynamic requestBody,
    required Function(Address) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await _addressRepository.createAddress(requestBody);

      if (response.statusCode ?? false) {
        onSuccess(response.data!);
      } else {
        errorMessage = response.message ?? "Failed to create address";
        onError(errorMessage!);
      }
    } catch (e) {
      errorMessage = e.toString();
      onError(errorMessage!);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateAddress({
    required String id,
    required dynamic requestBody,
    required Function(Address) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await _addressRepository.updateAddress(id, requestBody);

      if (response.statusCode ?? false) {
        onSuccess(response.data!);
      } else {
        errorMessage = response.message ?? "Failed to update address";
        onError(errorMessage!);
      }
    } catch (e) {
      errorMessage = e.toString();
      onError(errorMessage!);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteAddress({
    required String id,
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await _addressRepository.deleteAddress(id);

      if (response.statusCode ?? false) {
        onSuccess();
      } else {
        errorMessage = response.message ?? "Failed to delete address";
        onError(errorMessage!);
      }
    } catch (e) {
      errorMessage = e.toString();
      onError(errorMessage!);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
