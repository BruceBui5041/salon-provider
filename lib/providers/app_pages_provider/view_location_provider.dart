import 'dart:developer';

import 'package:salon_provider/config.dart';
import 'package:geolocator/geolocator.dart';

class ViewLocationProvider with ChangeNotifier {
  LatLng? position;
  GoogleMapController? mapController;
  double? newLog, newLat;
  Placemark? place;
  Set<Marker> markers = {};

  onController(controller) {
    mapController = controller;
    notifyListeners();
  }

  getUserCurrentLocation(context) async {
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
      place = placeMarks[0];
      markers = {};
      log("place : ${placeMarks[0]}");

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
}
