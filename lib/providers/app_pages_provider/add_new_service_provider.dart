import 'dart:developer';

import 'package:fixit_provider/config.dart';

class AddNewServiceProvider with ChangeNotifier {

  String? categoryValue;
  String? subCategoryValue;
  String? durationValue;
  int selectIndex = 0;
  String? taxIndex;
  bool isSwitch = false,isEdit = false;
  String argData = 'NULL';


  TextEditingController serviceName = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController duration = TextEditingController();
  TextEditingController availableService = TextEditingController();
  TextEditingController minRequired = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController discount = TextEditingController();
  TextEditingController tax = TextEditingController();
  TextEditingController featuredPoints = TextEditingController();

  FocusNode serviceNameFocus = FocusNode();
  FocusNode descriptionFocus = FocusNode();
  FocusNode durationFocus = FocusNode();
  FocusNode availableServiceFocus = FocusNode();
  FocusNode minRequiredFocus = FocusNode();
  FocusNode amountFocus = FocusNode();
  FocusNode discountFocus = FocusNode();
  FocusNode taxFocus = FocusNode();
  FocusNode featuredPointsFocus = FocusNode();
  XFile? imageFile,thumbFile;
  String? image,thumbImage;

  onReady(context){
    log("AGGG argdata $argData");
    dynamic data = ModalRoute.of(context)!.settings.arguments ?? "";
    log("AGGG DATATA $data");

    featuredPointsFocus.addListener(() {
     notifyListeners();
    });

    descriptionFocus.addListener(() {notifyListeners(); });

    if(data != ""){
     isEdit = data["isEdit"] ?? false;
     image =  data["image"] ?? "";
     thumbImage =  data["thumb_image"] ?? "";
     serviceName.text = data["service_name"] ?? "";
     categoryValue = data["category"] ?? 3;
     subCategoryValue = data["sub_category"] ?? 3;
     description.text = data["description"] ?? "";
     duration.text = data["duration"] ?? "2";
     availableService.text = data["area"] ?? "";
     minRequired.text = data["req_servicemen"] ?? "1";
     amount.text = data["price"] ?? "1";
     taxIndex = data["tax"] ?? 0;
     featuredPoints.text = data["featured_points"] ?? "";
     isSwitch = data["status"] ?? true;

     log("categoryValue ;$categoryValue");
     notifyListeners();
    }
  }

  onBack(){
    isEdit =  false;
    image =  "";
    thumbImage =  "";
    serviceName.text = "";
    categoryValue = null;
    subCategoryValue= null;
    description.text = "";
    duration.text = "";
    availableService.text = "";
    minRequired.text =  "";
    amount.text = "";
    taxIndex =  null;
    featuredPoints.text = "";
    isSwitch = false;
    notifyListeners();
  }

  onBackButton(context){
    route.pop(context);
    isEdit =  false;
    image =  "";
    thumbImage =  "";
    serviceName.text = "";
    categoryValue = null;
    subCategoryValue = null;
    description.text = "";
    duration.text = "";
    availableService.text = "";
    minRequired.text =  "";
    amount.text = "";
    taxIndex= null;
    featuredPoints.text = "";
    isSwitch = false;

    notifyListeners();
  }

  void updateInformation(information) {
    argData = information;
    notifyListeners();
  }

  onAvailableServiceTap(context) async{
    var result = await route.push(context, LocationListScreen());
     availableService.text =  result;
   notifyListeners();
  }

  // GET IMAGE FROM GALLERY
  Future getImage(context, source,isThumbnail) async {
    final ImagePicker picker = ImagePicker();
    if(isThumbnail) {
      route.pop(context);
      thumbFile = (await picker.pickImage(source: source))!;
    } else {
      route.pop(context);
      imageFile = (await picker.pickImage(source: source))!;
    }
    notifyListeners();
  }


  onImagePick(context,isThumbnail) {
      showLayout(context, onTap: (index) {
        if (index == 0) {
          if (isThumbnail) {
            getImage(context, ImageSource.gallery, isThumbnail);
          } else {
            getImage(context, ImageSource.gallery, isThumbnail).then((value) =>
                appArray.serviceImageList.add( imageFile!.path));
          }
          notifyListeners();
        } else {
          if (isThumbnail) {
            getImage(context, ImageSource.camera, isThumbnail);
          } else {
            getImage(context, ImageSource.camera, isThumbnail).then((value) =>
                appArray.serviceImageList.add( imageFile!.path));
          }
          notifyListeners();
        }
      });

  }

  onRemoveServiceImage(isThumbnail,{index}){
    if(isThumbnail) {
      thumbFile = null;
      notifyListeners();
    } else {

      appArray.serviceImageList.removeAt(index);
      notifyListeners();
    }
  }


  onTapSwitch(val){
    isSwitch = val;
    notifyListeners();
  }

  onChangeTax(index){
    taxIndex = index;
    notifyListeners();
  }

  onChangePrice(index){
    selectIndex = index;
    notifyListeners();
  }
  onChangeCategory(val) {

    categoryValue = val;
    log("VAL :$categoryValue");
    notifyListeners();
  }



    onChangeSubCategory(val) {
    subCategoryValue = val;
    notifyListeners();
  }

  onChangeDuration(val) {
    durationValue = val;
    notifyListeners();
  }

}