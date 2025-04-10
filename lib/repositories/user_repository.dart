import 'package:salon_provider/common/enum_value.dart';
import 'package:salon_provider/config/auth_config.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/config/repository_config.dart';
import 'package:salon_provider/model/request/search_request_model.dart';
import 'package:salon_provider/model/request/update_profile.dart';
import 'package:salon_provider/model/response/earning_response.dart';
import 'package:salon_provider/model/response/user_response.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salon_provider/network/api.dart';

class UserRepository extends RepositoryConfig {
  final api = getIt.get<UserApiClient>();

  Future<ProviderEarningResponse> getProviderEarnings({
    int? year,
    int? month,
    String? userId,
  }) async {
    try {
      var response = await api.getProviderEarnings(
        year: year,
        month: month,
        userId: userId,
      );

      if (response.data != null) {
        return response.data!;
      } else {
        throw Exception('Failed to fetch user: ${response.message}');
      }
    } catch (e) {
      throw Exception('Failed to fetch provider earnings: $e');
    }
  }

  Future<bool> updateUserProfile(
      String id, UpdateProfileRequestModel requestBody,
      {XFile? imageFile}) async {
    try {
      UpdateProfileRequestModel finalRequest = requestBody;

      if (imageFile != null) {
        // Create multipart file from image
        final file = await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        );

        finalRequest = requestBody.copyWith(profilePicture: file);
      }

      // Convert model to map and create FormData
      final Map<String, dynamic> data = {
        if (finalRequest.firstname != null) "firstname": finalRequest.firstname,
        if (finalRequest.lastname != null) "lastname": finalRequest.lastname,
        if (finalRequest.phoneNumber != null)
          "phone_number": finalRequest.phoneNumber,
        if (finalRequest.profilePicture != null)
          "profile_picture": finalRequest.profilePicture,
      };

      final formData = FormData.fromMap(data);
      var response = await api.updateUserProfile(id, formData);
      return response.data ?? false;
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }

  Future<UserResponse> getUser() async {
    try {
      String? userId = await AuthConfig.getUserId();
      var response = await commonRestClient.search<UserResponse>(
          SearchRequestBody(model: EnumColumn.user.name, conditions: [
        [
          Condition(source: "id", operator: "=", target: userId ?? ''),
        ]
      ], fields: [
        FieldItem(field: "roles"),
        FieldItem(field: "user_profile"),
      ]).toJson());
      var user = UserResponse.fromJson(response);
      return user;
    } catch (e) {
      throw Exception('Failed to fetch user: $e');
    }
  }
}
