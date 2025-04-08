import 'package:salon_provider/config.dart';

class SubscriptionPlanProvider with ChangeNotifier {
  SubscriptionPlanModel? subscriptionPlanModel;

  onReady() {
    subscriptionPlanModel =
        SubscriptionPlanModel.fromJson(appArray.subscriptionPlanList);
    notifyListeners();
  }
}
