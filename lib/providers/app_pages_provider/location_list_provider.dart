import 'dart:developer';
import 'package:fixit_provider/config.dart';
import 'package:flutter/cupertino.dart';


class LocationListProvider with ChangeNotifier {
  List selectedLocation = [];
  List addedLocation = [];
  List locationList = [
    {
      "title": "Howthorne - Los angels",
      "subtext": "USA - 90250",
      "zip": "90250",
      "latitude": "21.1702",
      "longitude": "72.8311",
      "address": "Howthorne - Los angels,USA - 90250",
    },{
      "title": "Aberdeen - Scotland",
      "subtext": "USA - 744104",
      "zip": "744104",
      "latitude": "21.1702",
      "longitude": "72.8311",
      "address": "Howthorne - Los angels,USA - 90250",
    },{
      "title": "Dundee - Scotland",
      "subtext": "USA - 01382",
      "zip": "01382",
      "latitude": "21.1702",
      "longitude": "72.8311",
      "address": "Howthorne - Los angels,USA - 90250",
    },{
      "title": "Howthorne - Los angels,",
      "subtext": "USA - 25633",
      "zip": "25633",
      "latitude": "21.1702",
      "longitude": "72.8311",
      "address": "Howthorne - Los angels,USA - 90250",
    },
  ];
  String? subtext;

  TextEditingController areaCtrl = TextEditingController();
  TextEditingController latitudeCtrl = TextEditingController();
  TextEditingController longitudeCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController zipcodeCtrl = TextEditingController();

  FocusNode areaFocus = FocusNode();
  FocusNode latitudeFocus = FocusNode();
  FocusNode longitudeFocus = FocusNode();
  FocusNode addressFocus = FocusNode();
  FocusNode zipcodeFocus = FocusNode();


  onTapLocation(id,val) {
    if (!selectedLocation.contains(id)) {
      selectedLocation.add(id);
      addedLocation.add(val);
    } else {
      selectedLocation.remove(id);
      addedLocation.remove(val);
    }
    notifyListeners();
  }

  onTapDetailLocationDelete (index,context,sync){

    final value = Provider.of<DeleteDialogProvider>(context, listen: false);

    value.onDeleteDialog(sync, context, eImageAssets.location, appFonts.delete, appFonts.areYiuSureDeleteLocation, (){
      addedLocation.removeAt(index);
      route.pop(context);
      notifyListeners();
    });
    value.notifyListeners();

    notifyListeners();
  }

  onLocationDelete(index,context,sync){
    final value = Provider.of<DeleteDialogProvider>(context, listen: false);

    value.onDeleteDialog(sync, context, eImageAssets.location, appFonts.delete, appFonts.areYiuSureDeleteLocation, (){
      locationList.removeAt(index);
      route.pop(context);
      notifyListeners();
    });
    value.notifyListeners();
    notifyListeners();
  }

  onAddSelectLocation(context){
    if(selectedLocation.isNotEmpty) {
      Navigator.pop(context, "${addedLocation[0]["title"]}");
     notifyListeners();
    } else {
      scaffoldMessage(context,appFonts.selectLocationFirst);
    }
  }

  onEditLocation(index,val,context){

    areaCtrl.text = val["title"];
    subtext = val["subtext"];
    latitudeCtrl.text = val["latitude"];
    longitudeCtrl.text = val["longitude"];
    zipcodeCtrl.text = val["zip"];
    addressCtrl.text = val["address"];
    notifyListeners();

    showModalBottomSheet(
        isScrollControlled: true,
        context: context, builder: (context) {
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
            alignment: Alignment.center,
            height: MediaQuery
                .of(context)
                .size
                .height / 1.39,
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(language(context, appFonts.editServiceArea),
                                style: appCss.dmDenseBold18
                                    .textColor(appColor(context).appTheme
                                    .darkText)),
                            const Icon(CupertinoIcons.multiply)
                                .inkWell(onTap: () => route.pop(context))
                          ]),
                      const VSpace(Sizes.s25),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(language(context, appFonts.areaLocality),
                                style: appCss.dmDenseMedium14.textColor(
                                    appColor(context).appTheme.darkText))
                                .paddingOnly(bottom: Insets.i8),
                            TextFieldCommon(
                                focusNode: areaFocus,
                                controller: areaCtrl,
                                hintText: appFonts.selectArea,
                                prefixIcon: eSvgAssets.address),
                            const VSpace(Sizes.s20),
                            Row(children: [
                              Expanded(
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(language(
                                            context, appFonts.latitude),
                                            style: appCss.dmDenseMedium14
                                                .textColor(
                                                appColor(context).appTheme
                                                    .darkText)).paddingOnly(
                                            bottom: Insets.i8),
                                        TextFieldCommon(
                                          keyboardType: TextInputType.number,
                                            focusNode: latitudeFocus,
                                            controller: latitudeCtrl,
                                            hintText: appFonts.enterHere,
                                            prefixIcon: eSvgAssets.locationOut)

                                      ])),
                              const HSpace(Sizes.s15),
                              Expanded(
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(language(
                                            context, appFonts.longitude),
                                            style: appCss.dmDenseMedium14
                                                .textColor(
                                                appColor(context).appTheme
                                                    .darkText)).paddingOnly(
                                            bottom: Insets.i8),
                                        TextFieldCommon(
                                            keyboardType: TextInputType.number,
                                            focusNode: longitudeFocus,
                                            controller: longitudeCtrl,
                                            hintText: appFonts.enterHere,
                                            prefixIcon: eSvgAssets.locationOut)

                                      ]))
                            ]),
                            const VSpace(Sizes.s20),
                            Text(language(context, appFonts.zipCode),
                                style: appCss.dmDenseMedium14.textColor(
                                    appColor(context).appTheme.darkText))
                                .paddingOnly(bottom: Insets.i8),
                            TextFieldCommon(
                                keyboardType: TextInputType.number,
                                focusNode: zipcodeFocus,
                                controller: zipcodeCtrl,
                                hintText: appFonts.zipCode,
                                prefixIcon: eSvgAssets.zipcode),
                            const VSpace(Sizes.s20),
                            Text(language(context, appFonts.address),
                                style: appCss.dmDenseMedium14.textColor(
                                    appColor(context).appTheme.darkText))
                                .paddingOnly(bottom: Insets.i8),
                            TextFieldCommon(
                                focusNode: addressFocus,
                                controller: addressCtrl,
                                hintText: appFonts.selectArea,
                                prefixIcon: eSvgAssets.address)
                          ]
                      ).paddingAll(Insets.i15).boxShapeExtension(
                          color: appColor(context).appTheme.fieldCardBg),
                      const VSpace(Sizes.s20),
                      BottomSheetButtonCommon(textOne: appFonts.cancel,
                          textTwo: appFonts.addArea,
                          applyTap: ()=> onAddArea(index,val,context),
                          clearTap: () => route.pop(context))
                    ]
                ).paddingAll(Insets.i20))).bottomSheetExtension(context,),
      );
    });
  }

  onAddArea(index,val,context){
    locationList.setAll(index, [
      {
        "title" : areaCtrl.text,
        "subtext" : subtext,
        "latitude" : latitudeCtrl.text ,
        "longitude" : longitudeCtrl.text,
        "zip" : zipcodeCtrl.text,
        "address" : addressCtrl.text
      }
    ]);
    route.pop(context);
    notifyListeners();

  }

}