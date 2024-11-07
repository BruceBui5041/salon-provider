import 'dart:convert';
import 'dart:developer';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import '../../config.dart';
import '../../screens/app_pages_screens/add_serviceman_screen/layouts/selection_option_layout.dart';


class ProfileDetailProvider with ChangeNotifier {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  String dialCode = '+91';
  final FocusNode nameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  XFile? imageFile;
  SharedPreferences? preferences;

  onUpdate(context){
    showDialog(context: context, builder: (context) => AlertDialogCommon(
      title: appFonts.updateSuccessfully,
      height: Sizes.s140,
      image: eGifAssets.successGif,
      subtext: language(context, appFonts.hurrayUpdateProfile),
      bText1: language(context, appFonts.okay),
      b1OnTap: ()=> route.pop(context)
    ));
  }


  var selectList = [
    {"image": eSvgAssets.gallery, "title": appFonts.chooseFromGallery},
    {"image": eSvgAssets.camera, "title": appFonts.openCamera}
  ];

  changeDialCode(CountryCodeCustom country) {
    dialCode = country.dialCode!;
    notifyListeners();
  }

// GET IMAGE FROM GALLERY
  Future getImage(context, source) async {
    final ImagePicker picker = ImagePicker();
    imageFile = (await picker.pickImage(source: source));
    notifyListeners();
    if (imageFile != null) {
      // updateProfile(context);
      route.pop(context);
    }
  }

  showLayout(context) async {
    showDialog(
      context: context,
      builder: (context1) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppRadius.r12))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(language(context, appFonts.selectOne),
                    style: appCss.dmDenseBold18
                        .textColor(appColor(context).appTheme.darkText)),
                const Icon(CupertinoIcons.multiply)
              ]),
              const VSpace(Sizes.s20),
              ...appArray.selectList
                  .asMap()
                  .entries
                  .map((e) => SelectOptionLayout(
                      data: e.value,
                      index: e.key,
                      list: appArray.selectList,
                      onTap: () {
                        if (e.key == 0) {
                          getImage(context, ImageSource.gallery);
                        } else {
                          getImage(context, ImageSource.camera);
                        }
                      }))
                  .toList()
            ],
          ),
        );
      },
    );
  }




}
