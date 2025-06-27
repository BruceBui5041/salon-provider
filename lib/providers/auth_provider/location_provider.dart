import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import '../../config.dart';

class LocationProvider with ChangeNotifier {
  AnimationController? animationController;
  LatLng? position;
  double? newLog, newLat;
  int primaryAddress = 0;
  String? currentAddress, street;
  Set<Marker> markers = {};
  GoogleMapController? mapController;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
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

  Placemark? place;
  bool isEdit = false, isCompany = false;
  int count = 0;
  dynamic argumentData;

  fetchCurrent(context) async {
    newLat = null;
    newLog = null;
    notifyListeners();
    getUserCurrentLocation(context);
  }

  onController(controller) {
    mapController = controller;
    notifyListeners();
  }

  onAnimate(TickerProvider sync) async {
    animationController = AnimationController(
        vsync: sync, duration: const Duration(milliseconds: 1200));
    _runAnimation();
    notifyListeners();
  }

  void _runAnimation() async {
    for (int i = 0; i < 300; i++) {
      await animationController!.forward();
      await animationController!.reverse();
    }
  }

  onTapLocationAdd(context) {
    final value = Provider.of<SignUpCompanyProvider>(context, listen: false);
    final location = Provider.of<LocationListProvider>(context, listen: false);
    appArray.serviceAvailableAreaList.add({
      "title": "${place!.name!} - ${place!.subLocality!}",
      "subtext": "${place!.country!} - ${place!.postalCode!}"
    });
    log("ADDED LIST ${appArray.serviceAvailableAreaList}");
    // location.locationList.add({
    //   "title": "${place!.name!} - ${place!.subLocality!}",
    //   "subtext": "${place!.country!} - ${place!.postalCode!}",
    //   "latitude": "${position!.latitude}",
    //   "longitude": "${position!.longitude}",
    //   "zip": "${place!.postalCode}",
    //   "address":
    //       "${place!.street!}, ${place!.name!}, ${place!.subLocality!}, ${place!.administrativeArea!}",
    // });
    value.notifyListeners();
    location.notifyListeners();
    notifyListeners();
  }

  // created method for getting user current location
  getUserCurrentLocation(context, {isRoute = false}) async {
    dynamic args = ModalRoute.of(context)?.settings.arguments ?? false;
    isCompany = args;
    notifyListeners();
    await Geolocator.requestPermission().then((value) async {
      log("GEO LOCATION : $value");
      Position position1 = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      position = LatLng(position1.latitude, position1.longitude);
      log("GET INIT LOC : $position");
      notifyListeners();
      getAddressFromLatLng(context);
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      log("ERROR $error");
    });
  }

  getAddressFromLatLng(context) async {
    log("NHNNN : ${position!.latitude}");
    await placemarkFromCoordinates(
            newLat ?? position!.latitude, newLog ?? position!.longitude)
        .then((List<Placemark> placeMarks) async {
      final locationVal =
          Provider.of<NewLocationProvider>(context, listen: false);
      place = placeMarks[0];
      markers = {};
      log("place : ${placeMarks[0]}");
      currentAddress = '${place!.name}';
      street =
          '${place!.name}, ${place!.street}, ${place!.subLocality}, ${place!.subAdministrativeArea}, ${place!.postalCode}';
      areaCtrl.text = place!.subLocality!;
      latitudeCtrl.text = position!.latitude.toString();
      longitudeCtrl.text = position!.longitude.toString();
      zipcodeCtrl.text = place!.postalCode!;
      addressCtrl.text =
          "${place!.name!}, ${place!.street}, ${place!.subLocality}";

      locationVal.latitudeCtrl.text = position!.latitude.toString();
      locationVal.longitudeCtrl.text = position!.longitude.toString();
      locationVal.zipCtrl.text = place!.postalCode!;
      locationVal.streetCtrl.text = place!.subLocality!;
      locationVal.cityCtrl.text = place!.locality!;
      locationVal.countryCtrl.text = place!.country!;
      locationVal.stateCtrl.text = place!.administrativeArea!;
      markers.add(Marker(
          draggable: true,
          onDragEnd: (value) {
            newLat = value.latitude;
            newLog = value.longitude;
            position = LatLng(value.latitude, value.longitude);
            if (newLat != null && newLog != null) {
              getAddressFromLatLng(context);
            }
            notifyListeners();
          },
          markerId: MarkerId(LatLng(
                  newLat ?? position!.latitude, newLog ?? position!.longitude)
              .toString()),
          position: LatLng(
              newLat ?? position!.latitude, newLog ?? position!.longitude),
          infoWindow:
              InfoWindow(title: place!.name, snippet: place!.subLocality),
          icon: await BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(devicePixelRatio: 2.5),
              eImageAssets.currentLocation) //Icon for Marker
          ));
      notifyListeners();
      log("NEW : ${position!.latitude}/ ${position!.longitude}");
    }).catchError((e) {
      debugPrint("ee : $e");
    });
  }

  onSuccess(context) {
    onTapLocationAdd(context);
    notifyListeners();
    showDialog(
        context: context,
        builder: (context1) {
          return AlertDialogCommon(
              title: appFonts.successfullyChanged,
              image: eGifAssets.successGif,
              subtext: appFonts.congratulation,
              bText1: appFonts.okay,
              height: Sizes.s145,
              b1OnTap: () {
                route.pop(context);
                route.pop(context);
                route.pop(context);
              });
        });
  }

  onEdit(context) {
    if (isCompany) {
      route.pushNamed(context, routeName.addNewLocation);
    } else {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return Consumer<DeleteDialogProvider>(
                builder: (context, value, child) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height / 1.39,
                        child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        language(
                                            context, appFonts.editServiceArea),
                                        style: appCss.dmDenseBold18.textColor(
                                            appColor(context)
                                                .appTheme
                                                .darkText)),
                                    const Icon(CupertinoIcons.multiply).inkWell(
                                        onTap: () => route.pop(context))
                                  ]),
                              const VSpace(Sizes.s25),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                            language(
                                                context, appFonts.areaLocality),
                                            style: appCss.dmDenseMedium14
                                                .textColor(appColor(context)
                                                    .appTheme
                                                    .darkText))
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                            Text(
                                                    language(context,
                                                        appFonts.latitude),
                                                    style: appCss
                                                        .dmDenseMedium14
                                                        .textColor(
                                                            appColor(context)
                                                                .appTheme
                                                                .darkText))
                                                .paddingOnly(bottom: Insets.i8),
                                            TextFieldCommon(
                                                keyboardType:
                                                    TextInputType.number,
                                                focusNode: latitudeFocus,
                                                controller: latitudeCtrl,
                                                hintText: appFonts.enterHere,
                                                prefixIcon:
                                                    eSvgAssets.locationOut)
                                          ])),
                                      const HSpace(Sizes.s15),
                                      Expanded(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                            Text(
                                                    language(context,
                                                        appFonts.longitude),
                                                    style: appCss
                                                        .dmDenseMedium14
                                                        .textColor(
                                                            appColor(context)
                                                                .appTheme
                                                                .darkText))
                                                .paddingOnly(bottom: Insets.i8),
                                            TextFieldCommon(
                                                keyboardType:
                                                    TextInputType.number,
                                                focusNode: longitudeFocus,
                                                controller: longitudeCtrl,
                                                hintText: appFonts.enterHere,
                                                prefixIcon:
                                                    eSvgAssets.locationOut)
                                          ]))
                                    ]),
                                    const VSpace(Sizes.s20),
                                    Text(language(context, appFonts.zipCode),
                                            style: appCss.dmDenseMedium14
                                                .textColor(appColor(context)
                                                    .appTheme
                                                    .darkText))
                                        .paddingOnly(bottom: Insets.i8),
                                    TextFieldCommon(
                                        keyboardType: TextInputType.number,
                                        focusNode: zipcodeFocus,
                                        controller: zipcodeCtrl,
                                        hintText: appFonts.zipCode,
                                        prefixIcon: eSvgAssets.zipcode),
                                    const VSpace(Sizes.s20),
                                    Text(language(context, appFonts.address),
                                            style: appCss.dmDenseMedium14
                                                .textColor(appColor(context)
                                                    .appTheme
                                                    .darkText))
                                        .paddingOnly(bottom: Insets.i8),
                                    TextFieldCommon(
                                        focusNode: addressFocus,
                                        controller: addressCtrl,
                                        hintText: appFonts.selectArea,
                                        prefixIcon: eSvgAssets.address)
                                  ]).paddingAll(Insets.i15).boxShapeExtension(
                                  color:
                                      appColor(context).appTheme.fieldCardBg),
                              const VSpace(Sizes.s20),
                              BottomSheetButtonCommon(
                                  textOne: appFonts.cancel,
                                  textTwo: appFonts.addArea,
                                  applyTap: () {
                                    onTapLocationAdd(context);
                                    notifyListeners();
                                    value.onResetPass(
                                        context,
                                        appFonts.congratulation,
                                        appFonts.okay, () {
                                      route.pop(context);
                                      route.pop(context);
                                      route.pop(context);
                                    }, title: appFonts.successfullyAdded);
                                  },
                                  clearTap: () => route.pop(context))
                            ]).paddingAll(Insets.i20)))
                    .bottomSheetExtension(
                  context,
                ),
              );
            });
          });
    }
  }
}
