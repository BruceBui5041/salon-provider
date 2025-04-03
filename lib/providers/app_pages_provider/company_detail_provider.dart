import 'dart:ui' as ui;
import 'package:figma_squircle_updated/figma_squircle.dart';
import 'package:salon_provider/model/countty_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../../config.dart';
import '../../widgets/state_country_dropdown.dart';

class CompanyDetailProvider with ChangeNotifier {
  TextEditingController cityCtrl = TextEditingController();
  TextEditingController zipcodeCtrl = TextEditingController();

  FocusNode cityFocus = FocusNode();
  FocusNode zipCodeFocus = FocusNode();

  List<CountryModel> countryList = [];
  CountryModel? country;
  String? areaValue;
  String? countryValue;
  double slider = 0;

  ui.Image? customImage;

  slidingValue(newValue) {
    slider = newValue;
    notifyListeners();
  }

  onTapSwitch(val, data) {
    data["status"] = val;
    notifyListeners();
  }

  onAreaTap(val) {
    areaValue = val;
    notifyListeners();
  }

  onChangeCountry(val) {
    country = val;
    notifyListeners();
  }

  onDeleteLocation(context, index) {
    final locationCtrl =
        Provider.of<NewLocationProvider>(context, listen: false);
    locationCtrl.locationList.removeAt(index);
    locationCtrl.notifyListeners();
    notifyListeners();
  }

  onEditLocation(context, val, index) {
    route.pushNamed(context, routeName.addNewLocation,
        arg: {"index": index, "isEdit": true, "data": val});
    notifyListeners();
  }

  onReady() {
    countryList = [];
    /* notifyListeners();
    appArray.countryList.asMap().entries.forEach((element) {
      if(!countryList.contains(CountryModel.fromJson(element.value))) {
        countryList.add(CountryModel.fromJson(element.value));
      }
    });*/
    notifyListeners();
  }

  onAddServiceArea(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Consumer<CompanyDetailProvider>(
              builder: (context, value, child) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height / 1.7,
                  decoration: ShapeDecoration(
                      color: appColor(context).appTheme.whiteBg,
                      shape: const SmoothRectangleBorder(
                          borderRadius: SmoothBorderRadius.only(
                              topLeft: SmoothRadius(
                                  cornerRadius: 10, cornerSmoothing: 1),
                              topRight: SmoothRadius(
                                  cornerRadius: 10, cornerSmoothing: 1)))),
                  child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(language(context, appFonts.addServiceArea),
                                  style: appCss.dmDenseBold18.textColor(
                                      appColor(context).appTheme.darkText)),
                              const Icon(CupertinoIcons.multiply)
                                  .inkWell(onTap: () => route.pop(context))
                            ]),
                        const VSpace(Sizes.s25),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(language(context, appFonts.area),
                                      style: appCss.dmDenseMedium14.textColor(
                                          appColor(context).appTheme.darkText))
                                  .paddingOnly(bottom: Insets.i8),
                              DropDownLayout(
                                  icon: eSvgAssets.address,
                                  val: areaValue,
                                  hintText: appFonts.selectArea,
                                  isIcon: true,
                                  // list: appArray.areaList,
                                  onChanged: (val) => onAreaTap(val)),
                              const VSpace(Sizes.s20),
                              Row(children: [
                                Expanded(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                      Text(language(context, appFonts.city),
                                              style: appCss.dmDenseMedium14
                                                  .textColor(appColor(context)
                                                      .appTheme
                                                      .darkText))
                                          .paddingOnly(bottom: Insets.i8),
                                      TextFieldCommon(
                                          focusNode: value.cityFocus,
                                          controller: cityCtrl,
                                          hintText: appFonts.city,
                                          prefixIcon: eSvgAssets.locationOut)
                                    ])),
                                const HSpace(Sizes.s15),
                                Expanded(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                      Text(language(context, appFonts.zipCode),
                                              style: appCss.dmDenseMedium14
                                                  .textColor(appColor(context)
                                                      .appTheme
                                                      .darkText))
                                          .paddingOnly(bottom: Insets.i8),
                                      TextFieldCommon(
                                          keyboardType: TextInputType.number,
                                          focusNode: value.zipCodeFocus,
                                          controller: zipcodeCtrl,
                                          hintText: appFonts.zipCode,
                                          prefixIcon: eSvgAssets.zipcode)
                                    ]))
                              ]),
                              const VSpace(Sizes.s20),
                              Text(language(context, appFonts.country),
                                      style: appCss.dmDenseMedium14.textColor(
                                          appColor(context).appTheme.darkText))
                                  .paddingOnly(bottom: Insets.i8),
                              // StateCountryDropdown(items: countryList,selectedItem: country,onChanged: (val) => onChangeCountry(val),)
                            ]).paddingAll(Insets.i15).boxShapeExtension(
                            color: appColor(context).appTheme.fieldCardBg),
                        const VSpace(Sizes.s20),
                        BottomSheetButtonCommon(
                            textOne: appFonts.cancel,
                            textTwo: appFonts.addArea,
                            applyTap: () {},
                            clearTap: () {})
                      ]).paddingAll(Insets.i20))),
            );
          });
        });
  }
}
