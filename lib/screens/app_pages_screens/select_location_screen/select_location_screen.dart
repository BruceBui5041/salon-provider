import '../../../config.dart';
import '../../../widgets/saved_location_layout.dart';
import 'dart:async';

class SelectCurrentLocationScreen extends StatefulWidget {
  const SelectCurrentLocationScreen({super.key});

  @override
  State<SelectCurrentLocationScreen> createState() =>
      _SelectCurrentLocationScreenState();
}

class _SelectCurrentLocationScreenState
    extends State<SelectCurrentLocationScreen> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  Timer? _debounceTimer;
  bool _showSearchResults = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider =
          Provider.of<LocationListProvider>(context, listen: false);
      // Only fetch saved addresses initially
      provider.getCurrentLocation(context);
    });

    // Add listener for search text changes
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim();

    // Cancel previous timer
    _debounceTimer?.cancel();

    if (query.isEmpty) {
      setState(() {
        _showSearchResults = false;
      });
      return;
    }

    setState(() {
      _showSearchResults = true;
    });

    // Only trigger search if there's actual text to search
    if (query.isNotEmpty) {
      // Set new timer for 1 second debounce
      _debounceTimer = Timer(const Duration(seconds: 1), () {
        if (mounted) {
          final provider =
              Provider.of<LocationListProvider>(context, listen: false);
          provider.searchLocations(context, query);
        }
      });
    }
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _showSearchResults = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationListProvider>(builder: (context, value, child) {
      return Scaffold(
          appBar: AppBar(
              leadingWidth: Navigator.of(context).canPop() ? 80 : 0,
              title: Text(language(context, appFonts.locationList),
                  style: appCss.dmDenseBold18
                      .textColor(appColor(context).appTheme.darkText)),
              centerTitle: true,
              leading: Navigator.of(context).canPop()
                  ? CommonArrow(
                      arrow: rtl(context)
                          ? eSvgAssets.arrowRight
                          : eSvgAssets.arrowLeft,
                      onTap: () => route.pop(context)).paddingAll(Insets.i8)
                  : null,
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
                              // Search field
                              Container(
                                margin: EdgeInsets.only(
                                    top: Insets.i20, bottom: Insets.i15),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(AppRadius.r10),
                                  border: Border.all(
                                    color: appColor(context).appTheme.stroke,
                                    width: 1,
                                  ),
                                ),
                                child: StatefulBuilder(
                                  builder: (context, setState) {
                                    return TextFieldCommon(
                                      controller: _searchController,
                                      focusNode: _searchFocusNode,
                                      hintText: appFonts.searchHere,
                                      prefixIcon: eSvgAssets.search,
                                      suffixIcon:
                                          _searchController.text.isNotEmpty
                                              ? InkWell(
                                                  onTap: () {
                                                    _clearSearch();
                                                    setState(() {});
                                                  },
                                                  child: Icon(
                                                    Icons.clear,
                                                    color: appColor(context)
                                                        .appTheme
                                                        .lightText,
                                                  ),
                                                )
                                              : null,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                    );
                                  },
                                ),
                              ),

                              // Show search results or saved addresses
                              if (_showSearchResults) ...[
                                // Search/Nearby results section
                                if (value.isLoadingNearby)
                                  Container(
                                    height: 200,
                                    child: const Center(
                                        child: CircularProgressIndicator()),
                                  )
                                else if (value.listNearByAddress.isEmpty)
                                  Container(
                                    height: 200,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            eSvgAssets.location,
                                            colorFilter: ColorFilter.mode(
                                              appColor(context)
                                                  .appTheme
                                                  .lightText,
                                              BlendMode.srcIn,
                                            ),
                                            width: 40,
                                            height: 40,
                                          ),
                                          const VSpace(Sizes.s10),
                                          Text(
                                            language(context,
                                                appFonts.ohhNoListEmpty),
                                            style: appCss.dmDenseMedium14
                                                .textColor(appColor(context)
                                                    .appTheme
                                                    .lightText),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                else
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        language(context, appFonts.searchHere),
                                        style: appCss.dmDenseBold16.textColor(
                                            appColor(context)
                                                .appTheme
                                                .darkText),
                                      ).paddingOnly(bottom: Insets.i10),
                                      ...value.listNearByAddress
                                          .asMap()
                                          .entries
                                          .map((e) {
                                        final address = e.value;
                                        final index = e.key;

                                        return SavedLocationLayout(
                                          type: appFonts.searchHere,
                                          isCheck:
                                              value.selectedLocation == address,
                                          onIconTap: () {
                                            value.onTapNearbyLocation(
                                                index, address);
                                          },
                                          isBorder: true,
                                          data: address,
                                          index: index,
                                          list: value.listNearByAddress,
                                        );
                                      }),
                                    ],
                                  ),
                              ] else ...[
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
                                        onIconTap: () =>
                                            value.onTapSavedLocation(
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
