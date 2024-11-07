import 'package:fixit_provider/config.dart';

class CommissionHistoryProvider extends ChangeNotifier {

  bool isCompletedMe = false;

  onTapSwitch(val){
    isCompletedMe = val;
    notifyListeners();
  }


}