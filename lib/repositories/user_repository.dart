import 'package:salon_provider/config/repository_config.dart';
import 'package:salon_provider/model/response/earning_response.dart';

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

      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch provider earnings: $e');
    }
  }
}
