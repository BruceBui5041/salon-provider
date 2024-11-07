import '../../../config.dart';

class CurrentLocationScreen extends StatelessWidget {
  const CurrentLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(builder: (context1, value, child) {
      return StatefulWrapper(
        onInit: ()=> Future.delayed(DurationsDelay.ms150).then((value1) => value.getUserCurrentLocation(context)),
        child: Scaffold(
            body: Stack(
          children: [
            if(value.position != null)
            GoogleMap(
                zoomGesturesEnabled: true,
                myLocationButtonEnabled: true,
                fortyFiveDegreeImageryEnabled: false,
                compassEnabled: false,
                mapToolbarEnabled: false,
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                        value.position!.latitude, value.position!.longitude),
                    zoom: 15),
                markers: value.markers,
                mapType: MapType.hybrid,
                onMapCreated: (controller) => value.onController(controller)),
            const BottomLocationLayout()
          ]
        )),
      );
    });
  }
}
