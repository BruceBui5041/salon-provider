import '../../../config.dart';


class PackageDetailsScreen extends StatefulWidget {
  const PackageDetailsScreen({super.key});

  @override
  State<PackageDetailsScreen> createState() => _PackageDetailsScreenState();
}

class _PackageDetailsScreenState extends State<PackageDetailsScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer2<PackageDetailProvider,DeleteDialogProvider>(builder: (context, value,deleteVal, child) {
      return StatefulWrapper(
        onDispose: ()=> deleteVal.onDispose(),
          onInit: () => Future.delayed(
              const Duration(milliseconds: 50), () => value.onReady()),
          child: Scaffold(
              appBar: ActionAppBar(title: appFonts.packageDetails, actions: [
                CommonArrow(
                        arrow: eSvgAssets.delete,onTap: ()=> value.onPackageDelete(context,this),
                        )
                    .paddingSymmetric(horizontal: Insets.i20)
              ]),
              body: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    PackageDetailsLayout(data: value.packageModel),
                    const DottedLines().paddingSymmetric(vertical: Insets.i15),
                    Text(language(context, appFonts.disclaimer),
                        style: appCss.dmDenseMedium12
                            .textColor(appColor(context).appTheme.darkText)),
                    Text(
                        language(context, appFonts.youWillOnlyGet),
                        style: appCss.dmDenseRegular12
                            .textColor(appColor(context).appTheme.red)),
                    ButtonCommon(title: appFonts.editPackage,onTap: ()=> route.pushNamed(context, routeName.appPackage,arg: {
                      'isEdit': true,
                      "data": {
                        "title": "Cleaning service",
                        "image": eImageAssets.package,
                        "price": "32.08",
                        "startDate": "12 Oct, 2023",
                        "expiryDate": "12 Nov, 2023",
                        "serviceIncluded": "3",
                        "status": true,
                        "description": "This package is very usefully and very cheap",
                        "disclaimer": "Once you buy this package then you can not cancelled this package",
                        "image_list": [
                          {"title": appFonts.acRepair, "icon": eImageAssets.pg1, "id": 1},
                        ]
                      },
                    }))
                        .paddingOnly(top: Insets.i40, bottom: Insets.i30)
                  ]).paddingSymmetric(horizontal: Insets.i20))));
    });
  }
}
