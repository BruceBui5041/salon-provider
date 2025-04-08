import 'package:salon_provider/common/enum_value.dart';
import 'package:salon_provider/config/auth_config.dart';
import 'package:salon_provider/config/repository_config.dart';
import 'package:salon_provider/model/request/search_request_model.dart';
import 'package:salon_provider/model/response/common_response.dart';
import 'package:salon_provider/model/response/earning_response.dart';
import 'package:salon_provider/model/response/user_response.dart';

class UserRepository extends RepositoryConfig {
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

  Future<UserResponse> getUser() async {
    try {
      String? userId = await AuthConfig.getUserId();
      var response = await commonRestClient.search<UserResponse>(
          UserResponse.fromJson,
          SearchRequestBody(model: EnumColumn.user.name, conditions: [
            [
              Condition(source: "id", operator: "=", target: userId ?? ''),
            ]
          ], fields: [
            FieldItem(field: "roles"),
            FieldItem(field: "user_profile"),
          ]).toJson());

      return response;
    } catch (e) {
      throw Exception('Failed to fetch user: $e');
    }
  }
}
