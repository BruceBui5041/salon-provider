import 'package:salon_provider/config.dart';
import '../../model/plan_model.dart';

class PlanDetailsProvider with ChangeNotifier {
  bool isMonthly = true;
  List<PlanModel> planList = [];
  int selIndex = 0;

  onPageChange(index, reason) {
    selIndex = index;
    notifyListeners();
  }

  onReady(month) {
    planList = [];
    planList = appArray
        .planList(month == false)
        .map((e) => PlanModel.fromJson(e))
        .toList();
    notifyListeners();
  }

  onToggle(val) {
    isMonthly = val;
    notifyListeners();
  }
}
