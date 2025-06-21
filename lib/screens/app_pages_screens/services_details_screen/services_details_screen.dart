import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:salon_provider/common/enum_value.dart';
import 'package:salon_provider/model/response/service_version_response.dart';
import 'package:salon_provider/providers/app_pages_provider/service_details_provider.dart';
import 'package:salon_provider/screens/app_pages_screens/add_new_service_screen/layouts/custom_image_viewer.dart';
import 'package:salon_provider/screens/app_pages_screens/services_details_screen/layouts/service_description.dart';
import 'package:salon_provider/widgets/booking_status_layout.dart';
import 'package:salon_provider/widgets/service_version_bottom_sheet.dart';

import '../../../config.dart';

class ServicesDetailsScreen extends StatefulWidget {
  const ServicesDetailsScreen({super.key});

  @override
  State<ServicesDetailsScreen> createState() => _ServicesDetailsScreenState();
}

class _ServicesDetailsScreenState extends State<ServicesDetailsScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ServiceDetailsProvider>(context, listen: false)
          .onInit(context);
    });
    super.initState();
  }

  String getPublishStatus(ServiceVersion? version) {
    if (version?.publishedDate == null) {
      return "Draft";
    }
    if (version?.status == ServiceVersionStatus.inactive.name &&
        version?.publishedDate != null) {
      return "Published";
    }

    return "Publishing";
  }

  Color colorCondition(String status, BuildContext context) {
    switch (status.toLowerCase()) {
      case 'draft':
        return appColor(context).appTheme.ongoing;
      case 'published':
        return appColor(context).appTheme.primary;
      case 'publishing':
        return appColor(context).appTheme.green;
      default:
        return appColor(context).appTheme.darkText;
    }
  }

  void _buildVersionBottomSheet(ServiceDetailsProvider value) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ServiceVersionBottomSheet(
        serviceVersionList: value.serviceVersionList,
        currentVersion: value.serviceVersionSelected,
        onVersionSelected: (version) {
          value.onVersionSelected(version);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ServiceDetailsProvider, LocationProvider>(
        builder: (context, value, val, child) {
      return Scaffold(
          body: SingleChildScrollView(
              child: Column(children: [
        ServiceImageLayout(
          editTap: () =>
              route.pushNamed(context, routeName.addNewService, arg: {
            "isEdit": true,
            "itemServiceSelected": value.itemService,
          }),
          deleteTap: () => value.onServiceDelete(context, this),
          titleWidget: value.serviceVersionSelected != null
              ? GestureDetector(
                  onTap: () => _buildVersionBottomSheet(value),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BookingStatusLayout(
                            title:
                                getPublishStatus(value.serviceVersionSelected),
                            color: colorCondition(
                                getPublishStatus(value.serviceVersionSelected)
                                    .toLowerCase(),
                                context),
                          ),
                          const SizedBox(height: Insets.i8),
                          Text(
                            value.serviceVersionSelected?.title ?? '',
                            style: appCss.dmDenseSemiBold18.textColor(
                                appColor(context).appTheme.whiteColor),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ],
                      ),
                      if (value.serviceVersionSelected?.id != null)
                        Text(
                          value.serviceVersionSelected?.id ?? "",
                          style: appCss.dmDenseRegular12
                              .textColor(appColor(context).appTheme.whiteColor),
                        ),
                    ],
                  ),
                )
              : Text(
                  value.itemService?.serviceVersion?.title ?? '',
                  style: appCss.dmDenseSemiBold18
                      .textColor(appColor(context).appTheme.whiteColor),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
          image: value.serviceVersionSelected?.mainImageResponse?.url ??
              value.itemService?.imageResponse?[0].url ??
              '',
          rating: "3.0",
        ),
        const VSpace(Sizes.s12),
        SizedBox(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: (value.serviceVersionSelected?.images?.length ??
                value.itemService?.imageResponse?.length ??
                0),
            itemBuilder: (context, index) => SizedBox(
              width: 100,
              child: ServicesImageLayout(
                  data: value.serviceVersionSelected?.images?[index].url ??
                      value.itemService?.imageResponse?[index].url ??
                      '',
                  index: index,
                  selectIndex: value.selectedIndex,
                  onTap: () {
                    // First update the selected image
                    value.onImageChange(
                        index,
                        value.serviceVersionSelected?.images?[index].url ??
                            value.itemService?.imageResponse?[index].url ??
                            '');

                    // Then show the image viewer
                    List<String> imageUrls = [];

                    if (value.serviceVersionSelected?.images != null) {
                      for (var img in value.serviceVersionSelected!.images!) {
                        imageUrls.add(img.url ?? '');
                      }
                    } else if (value.itemService?.imageResponse != null) {
                      for (var img in value.itemService!.imageResponse!) {
                        imageUrls.add(img.url ?? '');
                      }
                    }

                    List<ImageProvider> imageProviders =
                        imageUrls.map((url) => NetworkImage(url)).toList();

                    MultiImageProvider multiImageProvider =
                        MultiImageProvider(imageProviders, initialIndex: index);

                    showCustomImageViewerPager(
                      context,
                      multiImageProvider,
                      initialIndex: index,
                      doubleTapZoomable: true,
                      backgroundColor: Colors.black.withOpacity(0.85),
                      swipeDismissible: true,
                      closeButtonTooltip: "Close",
                      closeButtonColor: appColor(context).appTheme.whiteColor,
                    );
                  }),
            ),
          ),
        ),

        Column(children: [
          Stack(alignment: Alignment.center, children: [
            Image.asset(eImageAssets.servicesBg,
                width: MediaQuery.of(context).size.width),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(language(context, appFonts.amount),
                  style: appCss.dmDenseMedium12
                      .textColor(appColor(context).appTheme.primary)),
              Text(
                  value.serviceVersionSelected?.discountedPrice
                          ?.toCurrencyVnd() ??
                      value.itemService?.serviceVersion?.discountedPrice
                          ?.toCurrencyVnd() ??
                      '',
                  style: appCss.dmDenseBold18
                      .textColor(appColor(context).appTheme.primary))
            ]).paddingSymmetric(horizontal: Insets.i20)
          ]).paddingSymmetric(vertical: Insets.i15),
          ServiceDescription(data: value.itemService),
        ]).paddingSymmetric(horizontal: Insets.i20),

        //review
        Column(children: [
          // HeadingRowCommon(
          //         title: appFonts.review,
          //         onTap: () =>
          //             route.pushNamed(context, routeName.serviceReview))
          //     .paddingOnly(bottom: Insets.i12),
          // ...appArray.reviewList
          //     .asMap()
          //     .entries
          //     .map((e) => NewServiceReviewLayout(
          //         data: value.itemService,
          //         index: e.key,
          //         list: appArray.reviewList))
          //     .toList()
        ]).paddingAll(Insets.i20)
      ])));
    });
  }
}
