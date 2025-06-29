import '../../../config.dart';
import '../../../widgets/near_location_layout.dart';
import '../../../widgets/saved_location_layout.dart';

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
      // Reset nearby location flags when screen is loaded
      provider.resetNearbyLocationFlags();
      // Only fetch saved addresses initially, not nearby locations
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
                              // Show Near Location button or nearby locations
                              if (!value.hasShownNearbyLocations &&
                                  value.listNearByAddress.isEmpty) ...[
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(
                                      top: Insets.i20, bottom: Insets.i15),
                                  child: OutlinedButton.icon(
                                    onPressed: value.isLoadingNearby
                                        ? null
                                        : () =>
                                            value.showNearbyLocations(context),
                                    icon: value.isLoadingNearby
                                        ? SizedBox(
                                            width: 16,
                                            height: 16,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                appColor(context)
                                                    .appTheme
                                                    .primary,
                                              ),
                                            ),
                                          )
                                        : SvgPicture.asset(
                                            eSvgAssets.location,
                                            colorFilter: ColorFilter.mode(
                                              appColor(context)
                                                  .appTheme
                                                  .primary,
                                              BlendMode.srcIn,
                                            ),
                                            width: 18,
                                            height: 18,
                                          ),
                                    label: Text(
                                      value.isLoadingNearby
                                          ? language(context, appFonts.loading)
                                          : language(context,
                                              appFonts.showNearLocation),
                                      style: appCss.dmDenseMedium14.textColor(
                                        appColor(context).appTheme.primary,
                                      ),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                        color:
                                            appColor(context).appTheme.primary,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: Insets.i12,
                                        horizontal: Insets.i16,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(AppRadius.r8),
                                      ),
                                    ),
                                  ),
                                ),
                              ],

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

                                  return NearLocationLayout(
                                      isCheck:
                                          value.selectedLocation == address,
                                      onIconTap: () => value
                                          .onTapNearbyLocation(index, address),
                                      isBorder: true,
                                      data: address,
                                      index: index);
                                }),
                                Divider(
                                  color: appColor(context).appTheme.divider,
                                  thickness: 1,
                                ).paddingSymmetric(vertical: Insets.i20),
                              ],

                              // Saved addresses section from API
                              if (value.savedAddresses.isNotEmpty) ...[
                                Text(
                                  language(context, appFonts.recentLocations),
                                  style: appCss.dmDenseBold16.textColor(
                                      appColor(context).appTheme.darkText),
                                ).paddingOnly(bottom: Insets.i10),
                                ...value.savedAddresses
                                    .asMap()
                                    .entries
                                    .map((e) {
                                  final address = e.value;
                                  final index = e.key;

                                  return SavedLocationLayout(
                                      type: address.isDefault == true
                                          ? "current"
                                          : address.type,
                                      isCheck:
                                          value.selectedLocation == address,
                                      onIconTap: () => value.onTapSavedLocation(
                                          "saved_$index", address),
                                      isBorder: true,
                                      onEdit: null,
                                      onDelete: null,
                                      data: address,
                                      index: index,
                                      list: value.savedAddresses);
                                }),
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
