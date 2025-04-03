import 'package:salon_provider/config.dart';

class ServicemanListProvider with ChangeNotifier {
  List statusList = [];
  int selectIndex = 0;
  String? yearValue;
  String? expValue;
  TextEditingController categoryCtrl = TextEditingController();
  TextEditingController searchCtrl = TextEditingController();

  FocusNode searchFocus = FocusNode();
  FocusNode categoryFocus = FocusNode();

  onTapYear(val) {
    yearValue = val;
    notifyListeners();
  }

  onExperience(val) {
    expValue = val;
    notifyListeners();
  }

  onCategoryChange(context, id) {
    if (!statusList.contains(id)) {
      statusList.add(id);
    } else {
      statusList.remove(id);
    }
    notifyListeners();
  }

  onFilter(index) {
    selectIndex = index;
    notifyListeners();
  }

  onTapFilter(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (context) {
        return ServicemenBookingFilterLayout();
      },
    );
  }
}
