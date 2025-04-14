import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:salon_provider/providers/app_pages_provider/service_details_provider.dart';
import 'package:salon_provider/screens/app_pages_screens/services_details_screen/layouts/new_service_description%20copy.dart';

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
                  "price": value.itemService?.serviceVersion?.price ?? '0',
                  "tax": "VAT(20%)",
                  "featured_points": "What ever",
                  "status": false,
                  "itemServiceSelected": value.itemService,
                  // "discount":
                  //     value.itemService?.serviceVersion?.discountedPrice ?? '0',
                }),
            deleteTap: () => value.onServiceDelete(context, this),
            title: value.itemService?.serviceVersion?.title ?? '',
            image: value.itemService?.imageResponse?[0].url ?? '',
            rating: "3.0"),
        const VSpace(Sizes.s12),
        SizedBox(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: value.itemService?.imageResponse?.length ?? 0,
            itemBuilder: (context, index) => GestureDetector(
              onLongPress: () async {
                await showImageViewer(
                  context,
                  NetworkImage(
                      value.itemService?.imageResponse?[index].url ?? ''),
                  doubleTapZoomable: true,
                  backgroundColor: Colors.black.withOpacity(0.5),
                  swipeDismissible: true,
                );
              },
              child: SizedBox(
                width: 100,
                child: ServicesImageLayout(
                    data: value.itemService?.imageResponse?[index].url ?? '',
                    index: index,
                    selectIndex: value.selectedIndex,
                    onTap: () => value.onImageChange(
                        value.itemService?.imageResponse?[index].id ?? '',
                        value.itemService?.imageResponse?[index].url ?? '')),
              ),
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
