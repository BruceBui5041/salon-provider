import 'package:salon_provider/config.dart';

class BankDetailProvider with ChangeNotifier {
  String? branchValue;

  TextEditingController bankNameCtrl = TextEditingController();
  TextEditingController holderNameCtrl = TextEditingController();
  TextEditingController accountCtrl = TextEditingController();
  TextEditingController ifscCtrl = TextEditingController();
  TextEditingController swiftCtrl = TextEditingController();

  FocusNode bankNameFocus = FocusNode();
  FocusNode holdNameFocus = FocusNode();
  FocusNode accountFocus = FocusNode();
  FocusNode ifscFocus = FocusNode();
  FocusNode swiftFocus = FocusNode();

  onBranch(val) {
    branchValue = val;
    notifyListeners();
  }
}
