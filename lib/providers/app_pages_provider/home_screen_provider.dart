import 'package:salon_provider/config.dart';
import 'package:salon_provider/model/response/earning_response.dart';
import 'package:salon_provider/repositories/user_repository.dart';

class HomeScreenProvider with ChangeNotifier {
  final UserRepository _userRepository = UserRepository();
  ProviderEarningResponse? earningData;
  bool isLoading = false;
  String error = '';

  // Get the provider's earnings
  Future<void> getProviderEarnings({int? year, int? month}) async {
    try {
      isLoading = true;
      notifyListeners();

      earningData = await _userRepository.getProviderEarnings(
        year: year,
        month: month,
      );

      error = '';
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Get total earnings formatted for display
  String getTotalEarnings() {
    if (earningData == null || earningData!.totalEarnings == null) {
      return "0.00".toCurrencyVnd();
    }
    return earningData!.totalEarnings!.toCurrencyVnd();
  }
}
