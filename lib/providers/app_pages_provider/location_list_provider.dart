import 'package:salon_provider/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:salon_provider/model/request/location_req.dart';
import 'package:salon_provider/model/response/address_res.dart';
import 'package:salon_provider/repositories/location_repo.dart';
import 'package:salon_provider/config/injection_config.dart';

class LocationListProvider with ChangeNotifier {
  Address? selectedLocation;
  List addedLocation = [];
  List<Address> listNearByAddress = [];
  List locationList = [
    {
      "title": "Howthorne - Los angels",
      "subtext": "USA - 90250",
      "zip": "90250",
      "latitude": "21.1702",
      "longitude": "72.8311",
      "address": "Howthorne - Los angels,USA - 90250",
    },
    {
      "title": "Aberdeen - Scotland",
      "subtext": "USA - 744104",
      "zip": "744104",
      "latitude": "21.1702",
      "longitude": "72.8311",
      "address": "Howthorne - Los angels,USA - 90250",
    },
    {
      "title": "Dundee - Scotland",
      "subtext": "USA - 01382",
      "zip": "01382",
      "latitude": "21.1702",
      "longitude": "72.8311",
      "address": "Howthorne - Los angels,USA - 90250",
    },
    {
      "title": "Howthorne - Los angels,",
      "subtext": "USA - 25633",
      "zip": "25633",
      "latitude": "21.1702",
      "longitude": "72.8311",
      "address": "Howthorne - Los angels,USA - 90250",
    },
  ];
  List<Address> savedAddresses = [];
  String? subtext;
  bool isLoading = false;
  bool isLoadingNearby = false;
  bool hasShownNearbyLocations = false;

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

  // Fetch saved addresses for the current user
  Future<void> fetchSavedAddresses(BuildContext context) async {
    try {
      final locationRepo = getIt<LocationRepo>();
      savedAddresses = await locationRepo.getRecentAddresses();

      // Set default selection to the "current" location if available
      if (savedAddresses.isNotEmpty) {
        // Find the address with isDefault=true or type="current"
        final defaultAddress = savedAddresses.firstWhere(
          (address) => address.isDefault == true || address.type == "current",
          orElse: () => savedAddresses
              .first, // Fallback to first address if no current/default found
        );

        // Set as selected location
        selectedLocation = defaultAddress;

        // Sort the savedAddresses list to put the selected location on top
        if (selectedLocation != null) {
          savedAddresses
              .removeWhere((address) => address.id == selectedLocation!.id);
          savedAddresses.insert(0, selectedLocation!);
        }
      }

      notifyListeners();
    } catch (e) {
      scaffoldMessage(context,
          "${language(context, appFonts.errorFetchingLocationData)}: $e");
    }
  }

  // Get current location and fetch nearby locations
  Future<void> getCurrentLocation(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      // Also fetch saved addresses
      await fetchSavedAddresses(context);

      // Ensure a default selection is applied
      // (this should be handled by fetchSavedAddresses now, but in case it fails)
      if (selectedLocation == null && savedAddresses.isNotEmpty) {
        // Prioritize current/default location from saved addresses
        final defaultAddress = savedAddresses.firstWhere(
          (address) => address.isDefault == true || address.type == "current",
          orElse: () => savedAddresses.first,
        );

        selectedLocation = defaultAddress;
        // Add to addedLocation for backward compatibility
        addedLocation.clear();
        addedLocation.add({
          "title": defaultAddress.text ?? "",
          "subtext": defaultAddress.isDefault == true
              ? appFonts.defaultLocation
              : defaultAddress.type ?? "",
          "zip": "",
          "latitude": defaultAddress.latitude.toString(),
          "longitude": defaultAddress.longitude.toString(),
          "address": defaultAddress.text ?? "",
        });
      }
    } catch (e) {
      scaffoldMessage(context, "Error getting location: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Show nearby locations - separate method
  Future<void> showNearbyLocations(BuildContext context) async {
    if (hasShownNearbyLocations) return;

    isLoadingNearby = true;
    notifyListeners();

    try {
      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          scaffoldMessage(
              context, language(context, appFonts.locationPermissionDenied));
          isLoadingNearby = false;
          notifyListeners();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        scaffoldMessage(context,
            language(context, appFonts.locationPermissionPermanentlyDenied));
        isLoadingNearby = false;
        notifyListeners();
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ));

      // Use reverseGeocode to get location data
      await fetchNearbyLocations(position, context);
      hasShownNearbyLocations = true;
    } catch (e) {
      scaffoldMessage(context, "Error getting location: $e");
    } finally {
      isLoadingNearby = false;
      notifyListeners();
    }
  }

  // Fetch nearby locations using reverseGeocode
  Future<void> fetchNearbyLocations(
      Position position, BuildContext context) async {
    try {
      final locationRepo = getIt<LocationRepo>();
      final request = ReverseGeocodeReq(
          latlng: "${position.latitude},${position.longitude}");

      final response = await locationRepo.reverseGeocode(request);

      if (response.errorKey == null) {
        final addresses = response.data!;

        // Clear previous nearby locations
        listNearByAddress.clear();

        // Add the nearby locations to the list
        listNearByAddress.addAll(addresses);
      } else {
        scaffoldMessage(
            context, language(context, appFonts.failedToGetLocationDetails));
      }
    } catch (e) {
      scaffoldMessage(context,
          "${language(context, appFonts.errorFetchingLocationData)}: $e");
    }
  }

  onTapLocation(id, val) {
    // Legacy method - no longer used with single selection
    notifyListeners();
  }

  onTapNearbyLocation(int id, Address address) {
    selectedLocation = address;
    addedLocation.clear();

    addedLocation.add({
      "title": address.text ?? appFonts.currentLocation,
      "subtext": id == 0 ? appFonts.currentLocation : appFonts.nearbyLocation,
      "zip": "",
      "latitude": address.latitude.toString(),
      "longitude": address.longitude.toString(),
      "address": address.text ?? appFonts.currentLocation,
    });

    notifyListeners();
  }

  onTapSavedLocation(String id, Address address) {
    selectedLocation = address;
    addedLocation.clear();

    addedLocation.add({
      "title": address.text ?? "",
      "subtext": address.isDefault == true
          ? appFonts.defaultLocation
          : address.type ?? "",
      "zip": "",
      "latitude": address.latitude.toString(),
      "longitude": address.longitude.toString(),
      "address": address.text ?? "",
    });

    notifyListeners();
  }

  onTapDetailLocationDelete(index, context, sync) {
    final value = Provider.of<DeleteDialogProvider>(context, listen: false);

    value.onDeleteDialog(sync, context, eImageAssets.location, appFonts.delete,
        appFonts.areYiuSureDeleteLocation, () {
      addedLocation.removeAt(index);
      route.pop(context);
      notifyListeners();
    });
    value.notifyListeners();

    notifyListeners();
  }

  onLocationDelete(index, context, sync) {
    final value = Provider.of<DeleteDialogProvider>(context, listen: false);

    value.onDeleteDialog(sync, context, eImageAssets.location, appFonts.delete,
        appFonts.areYiuSureDeleteLocation, () {
      locationList.removeAt(index);
      route.pop(context);
      notifyListeners();
    });
    value.notifyListeners();
    notifyListeners();
  }

  onAddSelectLocation(context) async {
    if (selectedLocation != null) {
      isLoading = true;
      notifyListeners();

      final addressProvider =
          Provider.of<AddressProvider>(context, listen: false);

      // Call the provider method
      await addressProvider.chooseCurrentAddress(
        addressId: selectedLocation!.id,
        latitude: selectedLocation!.latitude.toString(),
        longitude: selectedLocation!.longitude.toString(),
        text: selectedLocation!.text,
        onSuccess: (success) {
          if (!success) {
            scaffoldMessage(context, language(context, appFonts.errorOccur));
          }
          route.pushNamed(context, routeName.dashboard);
        },
        onError: (error) {
          scaffoldMessage(context, error);
        },
      );
    } else {
      scaffoldMessage(context, language(context, appFonts.selectLocationFirst));
    }
  }

  onEditLocation(index, val, context) {
    areaCtrl.text = val["title"];
    subtext = val["subtext"];
    latitudeCtrl.text = val["latitude"];
    longitudeCtrl.text = val["longitude"];
    zipcodeCtrl.text = val["zip"];
    addressCtrl.text = val["address"];
    notifyListeners();

    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    language(context, appFonts.editServiceArea),
                                    style: appCss.dmDenseBold18.textColor(
                                        appColor(context).appTheme.darkText)),
                                const Icon(CupertinoIcons.multiply)
                                    .inkWell(onTap: () => route.pop(context))
                              ]),
                          const VSpace(Sizes.s25),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(language(context, appFonts.areaLocality),
                                        style: appCss.dmDenseMedium14.textColor(
                                            appColor(context)
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
                                                language(
                                                    context, appFonts.latitude),
                                                style: appCss.dmDenseMedium14
                                                    .textColor(appColor(context)
                                                        .appTheme
                                                        .darkText))
                                            .paddingOnly(bottom: Insets.i8),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                        Text(
                                                language(context,
                                                    appFonts.longitude),
                                                style: appCss.dmDenseMedium14
                                                    .textColor(appColor(context)
                                                        .appTheme
                                                        .darkText))
                                            .paddingOnly(bottom: Insets.i8),
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
                                            appColor(context)
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
                                        style: appCss.dmDenseMedium14.textColor(
                                            appColor(context)
                                                .appTheme
                                                .darkText))
                                    .paddingOnly(bottom: Insets.i8),
                                TextFieldCommon(
                                    focusNode: addressFocus,
                                    controller: addressCtrl,
                                    hintText: appFonts.selectArea,
                                    prefixIcon: eSvgAssets.address)
                              ]).paddingAll(Insets.i15).boxShapeExtension(
                              color: appColor(context).appTheme.fieldCardBg),
                          const VSpace(Sizes.s20),
                          BottomSheetButtonCommon(
                              textOne: appFonts.cancel,
                              textTwo: appFonts.addArea,
                              applyTap: () => onAddArea(index, val, context),
                              clearTap: () => route.pop(context))
                        ]).paddingAll(Insets.i20)))
                .bottomSheetExtension(
              context,
            ),
          );
        });
  }

  onAddArea(index, val, context) {
    locationList.setAll(index, [
      {
        "title": areaCtrl.text,
        "subtext": subtext,
        "latitude": latitudeCtrl.text,
        "longitude": longitudeCtrl.text,
        "zip": zipcodeCtrl.text,
        "address": addressCtrl.text
      }
    ]);
    route.pop(context);
    notifyListeners();
  }
}
