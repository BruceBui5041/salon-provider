import 'package:flutter/material.dart';
import 'package:salon_provider/model/request/address_req.dart';
import 'package:salon_provider/model/response/address_res.dart';
import 'package:salon_provider/repositories/address_repository.dart';

class AddressProvider extends ChangeNotifier {
  final AddressRepository _addressRepository;
  bool isLoading = false;
  String? errorMessage;

  AddressProvider(this._addressRepository);

  Future<void> chooseCurrentAddress({
    String? addressId,
    String? latitude,
    String? longitude,
    String? text,
    required Function(bool) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      final request = ChooseCurrentAddressReq(
        latitude: latitude,
        longitude: longitude,
        text: text,
      );

      if (addressId != null) {
        request.addressId = addressId;
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
