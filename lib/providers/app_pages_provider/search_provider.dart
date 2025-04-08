import 'dart:developer';

import 'package:salon_provider/config.dart';
import 'dart:ui' as ui;

class SearchProvider with ChangeNotifier {
  AnimationController? animationController;

  TextEditingController searchCtrl = TextEditingController();
  FocusNode searchFocus = FocusNode();
  List searchList = [];

  onReady() {
    searchList = appArray.popularServiceList;
    notifyListeners();
  }

  onSearch(String query) {
    searchList = appArray.popularServiceList
        .where(
            (item) => item["title"].toLowerCase().contains(query.toLowerCase()))
        .toList();
    log("SERD LIST ${searchList}");
    log("searchCtrl.text  ${searchCtrl.text}");
    if (searchCtrl.text == "") {
      searchList = [];
    }
    notifyListeners();
  }
}
