import 'package:fixit_provider/config.dart';


class AddExtraChargesProvider with ChangeNotifier {
  TextEditingController chargeTitleCtrl = TextEditingController();
  TextEditingController perServiceAmountCtrl = TextEditingController();
  FocusNode chargeTitleFocus = FocusNode();
  FocusNode perServiceAmountFocus = FocusNode();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int val = 1;

  onAddService() {
    val++;
    notifyListeners();
  }

  onRemoveService() {
    if(val > 1) {
      val--;
      notifyListeners();
    }
  }

  onAddCharge(context){
    if(formKey.currentState!.validate()) {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return UpdateBillSummaryBottom();
          });
    }
  }

  onUpdateBill(context){
    route.pop(context);
    route.pop(context);
    notifyListeners();
  }

}
