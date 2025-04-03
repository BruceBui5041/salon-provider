import 'package:salon_provider/config.dart';

import '../../model/commission_info_model.dart';

class CommissionInfoProvider with ChangeNotifier {
  TextEditingController searchCtrl = TextEditingController();
  FocusNode searchFocus = FocusNode();
  List<CommissionInfoModel> commissionList = [];

  onReady() {
    commissionList = [];
    appArray.commissionInfoList.asMap().entries.forEach((element) {
      if (!commissionList
          .contains(CommissionInfoModel.fromJson(element.value))) {
        commissionList.add(CommissionInfoModel.fromJson(element.value));
      }
    });
    notifyListeners();
  }
}
