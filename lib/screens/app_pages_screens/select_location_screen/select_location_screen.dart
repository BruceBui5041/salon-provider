import '../../../config.dart';

class SelectCurrentLocationScreen extends StatefulWidget {
  const SelectCurrentLocationScreen({super.key});

  @override
  State<SelectCurrentLocationScreen> createState() =>
      _SelectCurrentLocationScreenState();
}

class _SelectCurrentLocationScreenState
    extends State<SelectCurrentLocationScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider =
          Provider.of<LocationListProvider>(context, listen: false);
      provider.getCurrentLocation(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationListProvider>(builder: (context, value, child) {
      return Scaffold(
          appBar: AppBar(
              leadingWidth: 80,
              title: Text(language(context, appFonts.locationList),
                  style: appCss.dmDenseBold18
                      .textColor(appColor(context).appTheme.darkText)),
              centerTitle: true,
              leading: CommonArrow(
                  arrow: rtl(context)
                      ? eSvgAssets.arrowRight
                      : eSvgAssets.arrowLeft,
                  onTap: () => route.pop(context)).paddingAll(Insets.i8),
              actions: [
                CommonArrow(
                        arrow: eSvgAssets.add,
                        onTap: () =>
                            route.pushNamed(context, routeName.location))
                    .paddingOnly(right: Insets.i20)
              ]),
          body: value.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Nearby locations section
                              if (value.listNearByAddress.isNotEmpty) ...[
                                Text(
                                  language(context, appFonts.nearbyLocation),
                                  style: appCss.dmDenseBold16.textColor(
                                      appColor(context).appTheme.darkText),
                                ).paddingOnly(
                                    bottom: Insets.i10, top: Insets.i20),
                                ...value.listNearByAddress
                                    .asMap()
                                    .entries
                                    .map((e) {
                                  final address = e.value;
                                  final index = e.key;

                                  // Create a map for the ServicemanListLayout
                                  final addressMap = {
                                    "title": address.text ??
                                        language(
                                            context, appFonts.currentLocation),
                                    "subtext": index == 0
                                        ? language(
                                            context, appFonts.currentLocation)
                                        : language(
                                            context, appFonts.nearbyLocation),
                                    "latitude": address.latitude.toString(),
                                    "longitude": address.longitude.toString(),
                                    "address": address.text ??
                                        language(
                                            context, appFonts.currentLocation),
                                  };

                                  return ServicemanListLayout(
                                      isCheck: value.selectedLocation
                                              .contains(index) &&
                                          value.addedLocation
                                              .contains(addressMap),
                                      onIconTap: () => value
                                          .onTapNearbyLocation(index, address),
                                      isBorder: true,
                                      onEdit: null,
                                      onDelete: null,
                                      data: addressMap,
                                      index: index,
                                      list: value.listNearByAddress);
                                }).toList(),
                                Divider(
                                  color: appColor(context).appTheme.divider,
                                  thickness: 1,
                                ).paddingSymmetric(vertical: Insets.i20),
                              ],

                              // Saved addresses section from API
                              if (value.savedAddresses.isNotEmpty) ...[
                                Text(
                                  language(context, appFonts.savedLocations),
                                  style: appCss.dmDenseBold16.textColor(
                                      appColor(context).appTheme.darkText),
                                ).paddingOnly(bottom: Insets.i10),
                                ...value.savedAddresses
                                    .asMap()
                                    .entries
                                    .map((e) {
                                  final address = e.value;
                                  final index = e.key;

                                  // Create a map for the ServicemanListLayout
                                  final addressMap = {
                                    "title": address.text ?? "",
                                    "subtext": address.isDefault == true
                                        ? language(
                                            context, appFonts.defaultLocation)
                                        : address.type ?? "",
                                    "latitude": address.latitude.toString(),
                                    "longitude": address.longitude.toString(),
                                    "address": address.text ?? "",
                                  };

                                  return ServicemanListLayout(
                                      isCheck: value.selectedLocation
                                              .contains("saved_$index") &&
                                          value.addedLocation
                                              .contains(addressMap),
                                      onIconTap: () => value.onTapSavedLocation(
                                          "saved_$index", address),
                                      isBorder: true,
                                      onEdit: null,
                                      onDelete: null,
                                      data: addressMap,
                                      index: index,
                                      list: value.savedAddresses);
                                }).toList(),
                                Divider(
                                  color: appColor(context).appTheme.divider,
                                  thickness: 1,
                                ).paddingSymmetric(vertical: Insets.i20),
                              ],
                            ],
                          ).paddingSymmetric(horizontal: Insets.i20),
                        ),
                      ),
                      ButtonCommon(
                              title: appFonts.addSelectLocation,
                              onTap: () => value.onAddSelectLocation(context),
                              style: appCss.dmDenseRegular16.textColor(
                                  appColor(context).appTheme.primary),
                              color: appColor(context).appTheme.trans,
                              borderColor: appColor(context).appTheme.primary)
                          .paddingSymmetric(
                              horizontal: Insets.i20, vertical: Insets.i20)
                    ]));
    });
  }
}
