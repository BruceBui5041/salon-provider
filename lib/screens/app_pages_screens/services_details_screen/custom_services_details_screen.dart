import 'package:salon_provider/providers/app_pages_provider/custom_service_details_provider.dart';
import 'package:salon_provider/screens/app_pages_screens/services_details_screen/layouts/new_service_description%20copy.dart';
import 'package:salon_provider/screens/app_pages_screens/services_details_screen/layouts/new_service_review_layout.dart';

import '../../../config.dart';

class CustomServicesDetailsScreen extends StatefulWidget {
  const CustomServicesDetailsScreen({super.key});

  @override
  State<CustomServicesDetailsScreen> createState() =>
      _CustomServicesDetailsScreenState();
}

class _CustomServicesDetailsScreenState
    extends State<CustomServicesDetailsScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CustomServiceDetailsProvider>(context, listen: false)
          .onInit(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<CustomServiceDetailsProvider, LocationProvider>(
        builder: (context, value, val, child) {
      return Scaffold(
          body: SingleChildScrollView(
              child: Column(children: [
        ServiceImageLayout(
            editTap: () =>
                route.pushNamed(context, routeName.addNewService, arg: {
                  "isEdit": true,
                  "image": value.itemService?.imageResponse?[0].url ?? '',
                  "thumb_image": value.itemService?.imageResponse?[0].url ?? '',
                  "service_name":
                      value.itemService?.serviceVersion?.title ?? '',
                  "category": value.itemService?.serviceVersion
                          ?.categoryResponse?.name ??
                      '',
                  "sub_category": value.itemService?.serviceVersion
                          ?.categoryResponse?.name ??
                      '',
                  "description":
                      value.itemService?.serviceVersion?.description ?? '',
                  "duration": value.itemService?.serviceVersion?.duration ?? '',
                  "area": "Howthorne - Los angels",
                  "req_servicemen": "2",
                  "price": value.itemService?.serviceVersion?.price ?? '',
                  "tax": "VAT(20%)",
                  "featured_points": "What ever",
                  "status": false,
                  "itemServiceSelected": value.itemService,
                }),
            deleteTap: () => value.onServiceDelete(context, this),
            title: value.itemService?.serviceVersion?.title ?? '',
            image: value.itemService?.imageResponse?[0].url ?? '',
            rating: "3.0"),
        const VSpace(Sizes.s12),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: value.itemService?.imageResponse
                    ?.map((e) => ServicesImageLayout(
                        data: e.url,
                        index: e.hashCode,
                        selectIndex: value.selectedIndex,
                        onTap: () => value.onImageChange(e.id, e.url)))
                    .toList() ??
                []),
        Column(children: [
          Stack(alignment: Alignment.center, children: [
            Image.asset(eImageAssets.servicesBg,
                width: MediaQuery.of(context).size.width),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(language(context, appFonts.amount),
                  style: appCss.dmDenseMedium12
                      .textColor(appColor(context).appTheme.primary)),
              Text(
                  "\$${value.itemService?.serviceVersion?.discountedPrice?.toCurrencyVnd() ?? ''}",
                  style: appCss.dmDenseBold18
                      .textColor(appColor(context).appTheme.primary))
            ]).paddingSymmetric(horizontal: Insets.i20)
          ]).paddingSymmetric(vertical: Insets.i15),
          NewServiceDescription(data: value.itemService),
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
