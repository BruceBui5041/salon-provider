import 'package:salon_provider/config.dart';

class SelectServiceProvider with ChangeNotifier {
  List serviceList = [];
  List selectServiceList = [];

  TextEditingController searchCtrl = TextEditingController();
  FocusNode searchFocus = FocusNode();

  onImageRemove(id, index, val) {
    if (selectServiceList.contains(val)) {
      serviceList.remove(id);
      selectServiceList.removeAt(index);
    }
    notifyListeners();
  }

  onSelectService(context, id, val, index) {
    if (!serviceList.contains(id)) {
      serviceList.add(id);
      selectServiceList.add(val);
    } else {
      serviceList.remove(id);
      selectServiceList.removeAt(index);
    }
    notifyListeners();
  }
}
