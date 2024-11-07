import 'package:fixit_provider/config.dart';
import 'package:fixit_provider/model/payment_history_model.dart';


class WalletProvider with ChangeNotifier {

  List<PaymentHistoryModel> paymentHistoryList = [];

  int countryValue = 0;

  TextEditingController amountCtrl = TextEditingController();
  FocusNode amountFocus = FocusNode();

  onTapGateway(val){
    countryValue = val;
    notifyListeners();
  }

  onReady (){
    paymentHistoryList = [];
    notifyListeners();
    appArray.paymentHistoryList.asMap().entries.forEach((element) {
      if(!paymentHistoryList.contains(PaymentHistoryModel.fromJson(element.value))) {
        paymentHistoryList.add(PaymentHistoryModel.fromJson(element.value));
      }
    });
    notifyListeners();
  }

  onTapAdd(context){
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context2) {
        return AddMoneyLayout();
      },
    );
  }


}