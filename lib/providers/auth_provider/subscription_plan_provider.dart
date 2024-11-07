import 'package:fixit_provider/config.dart';
import 'package:fixit_provider/model/subscription_plan_model.dart';

class SubscriptionPlanProvider with ChangeNotifier {

     SubscriptionPlanModel? subscriptionPlanModel;

     onReady(){
        subscriptionPlanModel = SubscriptionPlanModel.fromJson(appArray.subscriptionPlanList);
        notifyListeners();
     }

}