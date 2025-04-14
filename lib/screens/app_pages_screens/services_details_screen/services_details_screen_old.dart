import '../../../config.dart';

class ServicesDetailsScreenOld extends StatefulWidget {
  const ServicesDetailsScreenOld({super.key});

  @override
  State<ServicesDetailsScreenOld> createState() =>
      _ServicesDetailsScreenOldState();
}

class _ServicesDetailsScreenOldState extends State<ServicesDetailsScreenOld>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ServiceDetailsProviderOld, LocationProvider>(
        builder: (context, value, val, child) {
      return Scaffold(
          body: SingleChildScrollView(
              child: Column(children: [
        ServiceImageLayout(
            editTap: () =>
                route.pushNamed(context, routeName.addNewService, arg: {
                  "isEdit": true,
                  "image": eImageAssets.as3,
                  "thumb_image": eImageAssets.as1,
                  "service_name": "Ac repair",
                  "category": "Ac cleaning",
                  "sub_category": "Cleaning",
                  "description": "What ever",
                  "duration": "1",
                  "area": "Howthorne - Los angels",
                  "req_servicemen": "2",
                  "price": "400",
                  "tax": "VAT(20%)",
                  "featured_points": "What ever",
                  "status": false
                }),
            deleteTap: () => value.onServiceDelete(context, this),
            title: "AC cleaning service",
            image: value.selectedImage ?? eImageAssets.servicesImage,
            rating: "3.0"),
        const VSpace(Sizes.s12),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: appArray.servicesImageList
                .asMap()
                .entries
                .map((e) => ServicesImageLayout(
                    data: e.value,
                    index: e.key,
                    selectIndex: value.selectedIndex,
                    onTap: () => value.onImageChange(e.key, e.value)))
                .toList()),
        Column(children: [
          Stack(alignment: Alignment.center, children: [
            Image.asset(eImageAssets.servicesBg,
                width: MediaQuery.of(context).size.width),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(language(context, appFonts.amount),
                  style: appCss.dmDenseMedium12
                      .textColor(appColor(context).appTheme.primary)),
              Text("\$12.00",
                  style: appCss.dmDenseBold18
                      .textColor(appColor(context).appTheme.primary))
            ]).paddingSymmetric(horizontal: Insets.i20)
          ]).paddingSymmetric(vertical: Insets.i15),
          const ServiceDescription(),
        ]).paddingSymmetric(horizontal: Insets.i20),
        Column(children: [
          HeadingRowCommon(
                  title: appFonts.review,
                  onTap: () =>
                      route.pushNamed(context, routeName.serviceReview))
              .paddingOnly(bottom: Insets.i12),
          ...appArray.reviewList
              .asMap()
              .entries
              .map((e) => ServiceReviewLayout(
                  data: e.value, index: e.key, list: appArray.reviewList))
              .toList()
        ]).paddingAll(Insets.i20)
      ])));
    });
  }
}
