import 'dart:developer';

import 'package:fixit_provider/config.dart';
import 'package:flutter/services.dart';
import '../../model/countty_model.dart';


class SignUpCompanyProvider with ChangeNotifier {
  GlobalKey<FormState>  signupFormKey = GlobalKey<FormState>();
  double slider = 0.0;
  String dialCode = "+91";
  String languageSelect = "[]";
  String? chosenValue;
  String? countryValue;
  int pageIndex = 0;
  int fPageIndex = 0;
  CountryModel? countryCompany,countryProvider,stateCompany,stateProvider;
  List<CountryModel> countryList = [];
  List<CountryModel> stateList = [];
  ScrollController controller =  ScrollController();

  TextEditingController companyName = TextEditingController();
  TextEditingController phoneName = TextEditingController();
  TextEditingController companyMail = TextEditingController();
  TextEditingController experience = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController providerNumber = TextEditingController();

  TextEditingController identityNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController reEnterPassword = TextEditingController();

  TextEditingController street = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController zipCode = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController country = TextEditingController();

  TextEditingController ownerName = TextEditingController();
  TextEditingController providerPhoneNumber = TextEditingController();
  TextEditingController providerEmail = TextEditingController();


  final FocusNode companyNameFocus = FocusNode();
  final FocusNode phoneNameFocus = FocusNode();
  final FocusNode companyMailFocus = FocusNode();
  final FocusNode experienceFocus = FocusNode();
  final FocusNode descriptionFocus = FocusNode();
  final FocusNode providerNumberFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();

  final FocusNode identityNumberFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode reEnterPasswordFocus = FocusNode();

  FocusNode streetFocus = FocusNode();
  FocusNode cityFocus = FocusNode();
  FocusNode zipcodeFocus = FocusNode();
  FocusNode stateFocus = FocusNode();
  FocusNode countryFocus = FocusNode();

  FocusNode ownerNameFocus = FocusNode();
  FocusNode providerPhoneNumberFocus = FocusNode();
  FocusNode providerEmailFocus = FocusNode();

  XFile? imageFile;

  // GET IMAGE FROM GALLERY
  Future getImage(context, source) async {
    final ImagePicker picker = ImagePicker();
    route.pop(context);
    imageFile = (await picker.pickImage(source: source))!;
    notifyListeners();
  }

  onImagePick(context) {
    showLayout(context, onTap: (index) {
      if (index == 0) {
        getImage(context, ImageSource.gallery);
      } else {
        getImage(context, ImageSource.camera);
      }
      notifyListeners();
    });
  }

  onLanguageSelect(options) {
   languageSelect = options.toString();
   notifyListeners();
  }

  onLocationDelete(index,context,sync){
   final value = Provider.of<DeleteDialogProvider>(context, listen: false);

   value.onDeleteDialog(sync, context, eImageAssets.location, appFonts.delete, appFonts.areYiuSureDeleteLocation, (){
     appArray.serviceAvailableAreaList.removeAt(index);
     route.pop(context);
     notifyListeners();
   });
   value.notifyListeners();

  }

  onChangeCountryCompany(val) {
    countryCompany = val;
    notifyListeners();
  }
  onChangeStateCompany(val) {
    stateCompany = val;
    notifyListeners();
  }

  onReady(){
    countryList = [];
    stateList = [];
    notifyListeners();
    appArray.countryObjectList.asMap().entries.forEach((element) {
      if(!countryList.contains(CountryModel.fromJson(element.value))) {
        countryList.add(CountryModel.fromJson(element.value));
      }
    });

    appArray.countryObjectList.asMap().entries.forEach((element) {
      if(!stateList.contains(CountryModel.fromJson(element.value))) {
        stateList.add(CountryModel.fromJson(element.value));
      }
    });
    descriptionFocus.addListener(() {notifyListeners();});
    notifyListeners();
  }


  changeDialCode(CountryCodeCustom country) {
    dialCode = country.dialCode!;
    notifyListeners();
  }

  onDropDownChange(choseVal) {
    chosenValue = choseVal;
    notifyListeners();
  }


  slidingValue(newValue) {
    slider = newValue;
    notifyListeners();
  }

  onChangeCountry(val) {
    countryValue = val;
    notifyListeners();
  }

   scrollAnimated(double position) {
    controller.animateTo(position, duration: Duration(seconds: 1), curve: Curves.ease);
    notifyListeners();
  }

  onFreelancerTap(context) async{
    scrollAnimated(1);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    fPageIndex++;
    if(fPageIndex == 2) {
      prefs.setBool(session.isLogin,true);
      notifyListeners();
      route.pushReplacementNamed(context, routeName.dashboard);
    }
    log("INDEXESFREEE $fPageIndex");
    notifyListeners();
  }

  onNext(context) async{
    scrollAnimated(1);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    pageIndex++;
    if(pageIndex == 3){
      prefs.setBool(session.isLogin,true);
       route.pushReplacementNamed(context, routeName.dashboard);
    }
    log("INDEXEPAGE $pageIndex");
    notifyListeners();
  }

  popInvokeFree (didPop) async{
    scrollAnimated(1);
    fPageIndex = 0;
    notifyListeners();
  }

  popInvoke (didPop) async{
    scrollAnimated(1);
    pageIndex --;
    notifyListeners();
  }

}