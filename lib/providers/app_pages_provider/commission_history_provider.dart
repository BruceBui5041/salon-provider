import 'package:flutter/material.dart';

class CommissionHistoryProvider extends ChangeNotifier {
  bool isCompletedMe = false;

  onTapSwitch(val) {
    isCompletedMe = val;
    notifyListeners();
  }
}
