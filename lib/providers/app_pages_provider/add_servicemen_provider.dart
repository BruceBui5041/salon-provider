import 'dart:developer';
import 'package:salon_provider/config.dart';
import 'package:salon_provider/model/response/service_response.dart';

class AddServicemenProvider with ChangeNotifier {
  String dialCode = "+91";
  String? countryValue;
  String? locationValue;
  String? chosenValue;
  XFile? imageFile, profileFile;
  final List<Color> colorCollection = <Color>[];
  String languageSelect = "[]";
  Service? itemService;

  TextEditingController userName = TextEditingController();
  TextEditingController phoneName = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController experience = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController identityNumber = TextEditingController();
  TextEditingController password = TextEditingController();

  final FocusNode userNameFocus = FocusNode();
  final FocusNode phoneNameFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode experienceFocus = FocusNode();
  final FocusNode descriptionFocus = FocusNode();
  final FocusNode providerNumberFocus = FocusNode();
  final FocusNode identityNumberFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();

  addColorToArray() {
    //Here you can add color as your requirement and call it in initState
    colorCollection.add(Colors.green);
    colorCollection.add(Colors.red);
    colorCollection.add(Colors.pink);
    colorCollection.add(Colors.yellow);
    colorCollection.add(Colors.blue);
    colorCollection.add(Colors.brown);
    colorCollection.add(Colors.lightGreen);
    colorCollection.add(Colors.cyan);
    colorCollection.add(Colors.deepOrange);
    notifyListeners();
  }

  onLanguageSelect(options) {
    languageSelect = options.toString();
    notifyListeners();
  }

  onReady() {
    addColorToArray();
    descriptionFocus.addListener(() {
      notifyListeners();
    });
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

  onChangeCountry(val) {
    countryValue = val;
    notifyListeners();
  }

  onLocation(val) {
    locationValue = val;
    notifyListeners();
  }

  // GET IMAGE FROM GALLERY
  Future getImage(context, source, isProfile) async {
    final ImagePicker picker = ImagePicker();
    if (isProfile == true) {
      route.pop(context);
      profileFile = (await picker.pickImage(source: source))!;
    } else {
      route.pop(context);
      imageFile = (await picker.pickImage(source: source))!;
    }
    notifyListeners();
  }

  onImagePick(context, isProfile) {
    showLayout(context, onTap: (index) {
      log("INDEX : $index");
      if (index == 0) {
        getImage(context, ImageSource.gallery, isProfile);
      } else {
        getImage(context, ImageSource.camera, isProfile);
      }
    });
  } /*
onReady(){
    servicePackageModel = ServicePackageModel.fromJson(appArray.packageDetailList);
    notifyListeners();
}*/
}
