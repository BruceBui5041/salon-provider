import '../../config.dart';

class ServiceReviewProvider with ChangeNotifier {

  String? exValue;
  String? settingExValue;
  bool isSetting = false;

  onBack(context){
    isSetting = false;
    notifyListeners();
    route.pop(context);
  }

  onBackButton(){
    isSetting = false;
    notifyListeners();
  }

  onReview(val){
    exValue = val;
    notifyListeners();
  }

  onSettingReview(val){
    settingExValue = val;
    notifyListeners();
  }

  onReady(context){
    dynamic data = ModalRoute.of(context)!.settings.arguments ?? false;
    if(data != null){
      isSetting = data;
    }
    notifyListeners();
  }

}
