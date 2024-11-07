import 'dart:convert';
import 'dart:developer';
import '../../config.dart';


class NewLocationProvider with ChangeNotifier {

  List locationList = [];
  int selectIndex = 0;
  int? argIndex;
  bool? status;
  List categoryList = [
    appFonts.home,
    appFonts.work,
    appFonts.other,
  ];

  bool isCheck = false, isEdit = false;
  GlobalKey<FormState> locationFormKey = GlobalKey<FormState>();

  String dialCode = "+91";
  TextEditingController streetCtrl = TextEditingController();
  TextEditingController countryCtrl = TextEditingController();
  TextEditingController stateCtrl = TextEditingController();
  TextEditingController cityCtrl = TextEditingController();
  TextEditingController zipCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController numberCtrl = TextEditingController();
  TextEditingController latitudeCtrl = TextEditingController();
  TextEditingController longitudeCtrl = TextEditingController();

  final FocusNode nameFocus = FocusNode();
  final FocusNode numberFocus = FocusNode();
  final FocusNode zipFocus = FocusNode();
  final FocusNode cityFocus = FocusNode();
  final FocusNode stateFocus = FocusNode();
  final FocusNode countryFocus = FocusNode();
  final FocusNode streetFocus = FocusNode();
  final FocusNode latitudeFocus = FocusNode();
  final FocusNode longitudeFocus = FocusNode();

  int countryValue = -1, stateValue = -1;

  getOnInitData(context) {
    dynamic data = ModalRoute.of(context)!.settings.arguments ?? '';
     log("ARGS DATA ${data}");
     if(data != "" ){
       argIndex = data["index"] ?? 0;
       isEdit = data["isEdit"] ?? false;
       selectIndex = data["data"]["category"] ?? '';
       latitudeCtrl.text = data["data"]["latitude"] ?? '';
       longitudeCtrl.text = data["data"]["longitude"] ?? '';
       countryCtrl.text = data["data"]["country"] ?? '';
       stateCtrl.text = data["data"]["state"] ?? '';
       zipCtrl.text = data["data"]["zip_code"] ?? '';
       streetCtrl.text = data["data"]["street"] ?? '';
       cityCtrl.text = data["data"]["city"] ?? '';
       status = data["data"]["status"] ?? false;
     }

    notifyListeners();
  }

  isCheckBoxCheck(value) {
    isCheck = value;
    notifyListeners();
  }

  onBack() {
    streetCtrl.text = "";
    stateCtrl.text = "";
    countryCtrl.text = "";
    dialCode = "+91";
    cityCtrl.text = "";
    zipCtrl.text = "";
    nameCtrl.text = "";
    numberCtrl.text = "";
    countryCtrl.text = "";
    stateCtrl.text = "";
    isEdit = false;
    notifyListeners();
  }

  onBackButton(context) {
    streetCtrl.text = "";
    stateCtrl.text = "";
    countryCtrl.text = "";
    dialCode = "+91";
    cityCtrl.text = "";
    zipCtrl.text = "";
    nameCtrl.text = "";
    numberCtrl.text = "";
    countryCtrl.text = "";
    stateCtrl.text = "";
    isEdit = false;
    route.pop(context);
    notifyListeners();
  }

  changeDialCode(CountryCode country) {
    dialCode = country.dialCode!;
    notifyListeners();
  }

  onCategory(index) {
    selectIndex = index;
    notifyListeners();
  }

  onChangeCountry(context, val) {
    countryValue = val;
    final locationCtrl = Provider.of<LocationProvider>(context, listen: false);

    locationCtrl.notifyListeners();
    notifyListeners();
  }

  onChangeState(val) {
    stateValue = val;
    notifyListeners();
  }

  onAddLocation(context) {
    FocusScope.of(context).requestFocus(FocusNode());
    if (locationFormKey.currentState!.validate()) {
      if (isEdit) {
        editAddress(context);
      } else {
        addAddress(context);
      }
    }
  }

  //add Address
  addAddress(context) async {
    final data = Provider.of<DeleteDialogProvider>(context,listen: false);
    locationList.add({
        "category": selectIndex,
        "street": streetCtrl.text,
        "latitude": latitudeCtrl.text,
        "longitude": longitudeCtrl.text,
        "country": countryCtrl.text,
        "state": stateCtrl.text,
        "city": cityCtrl.text,
        "zip_code": zipCtrl.text,
        "status": true
    });
    notifyListeners();
    data.onResetPass(context, language(context, appFonts.congLocationSuccessAdded),language(context, appFonts.okay),() {
      route.pop(context);
      route.pop(context);
      route.pop(context);
    },title: appFonts.successfullyAdded);
  }

  //edit Address
  editAddress(context) async {
     locationList.setAll(argIndex!, [
       {
         "category": selectIndex,
         "street": streetCtrl.text,
         "latitude": latitudeCtrl.text,
         "longitude": longitudeCtrl.text,
         "country": countryCtrl.text,
         "state": stateCtrl.text,
         "city": cityCtrl.text,
         "zip_code": zipCtrl.text,
         "status": status,
       }
     ]);
     notifyListeners();
     route.pop(context);
  }
}
