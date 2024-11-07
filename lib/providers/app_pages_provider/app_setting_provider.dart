
import 'dart:convert';
import 'dart:developer';
import '../../config.dart';



class AppSettingProvider with ChangeNotifier {
  int selectIndex = 0;
  bool isNotification = true;
  final SharedPreferences sharedPreferences;

  AppSettingProvider(this.sharedPreferences);

  heightMQ(context) {
    double height = MediaQuery.of(context).size.height;
    return height;
  }

  widthMQ(context) {
    double width = MediaQuery.of(context).size.width;
    return width;
  }

  onTapData(context, index) {
    log("dsf");
    if (index == 2) {
      currencyBottomSheet(context);
    } else if (index == 3) {
      route.pushNamed(context, routeName.changeLanguage);
    } else if (index == 4) {
      route.pushNamed(context, routeName.changePassword);
    }
  }

  onNotification(val){
    isNotification = val;
    notifyListeners();
  }

  onBack(){
    notifyListeners();
  }

  onChangeButton(index) async {
    selectIndex = index;
   notifyListeners();
  }

  onUpdate(context,data){
    currency(context).priceSymbol = data["symbol"].toString();

    currency(context).currency = jsonDecode(
        sharedPreferences.getString('selectedCurrency').toString()) ??
        appArray.currencyList[0];

    sharedPreferences.setString('selectedCurrency', jsonEncode(data));

    currency(context).notifyListeners();
    notifyListeners();
    if (currency(context).currency != data) {

      currency(context).currencyVal =
          double.parse(currency(context).currency[data["code"]].toString());
      notifyListeners();
      currency(context).notifyListeners();
    }
    route.pop(context);
  }



  currencyBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context2) {
        return CurrencyBottomSheet();
      },
    );
  }
}
