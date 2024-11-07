import 'package:fixit_provider/model/package_detail_model.dart';
import '../../../../config.dart';


class PackageDetailsLayout extends StatelessWidget {
  final PackageDetailModel? data;
  const PackageDetailsLayout({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Column(
              children: [
                Image.asset(eImageAssets.packageBg),
                const VSpace(Sizes.s10),
                Text(language(context, data!.package),
                    style: appCss.dmDenseMedium16
                        .textColor(appColor(context).appTheme.darkText)),
                const VSpace(Sizes.s4),
                Text(language(context, "\$${data!.price}"),
                    style: appCss.dmDenseblack18
                        .textColor(appColor(context).appTheme.online))
              ]
          ).paddingSymmetric(horizontal: Insets.i15),
          const VSpace(Sizes.s15),
           PackageDescriptionLayout(data: data!),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(language(context, appFonts.includedService),
                    style: appCss.dmDenseMedium14
                        .textColor(appColor(context).appTheme.darkText)).paddingOnly(top: Insets.i15,bottom: Insets.i10),
                Column(
                  children: data!.includedServices!.asMap().entries.map((e) => PackageIncludeServiceLayout(data: e.value,index: e.key,list: data!.includedServices!)).toList(),
                ).paddingSymmetric(vertical: Insets.i15).boxShapeExtension(color: appColor(context).appTheme.fieldCardBg,radius: AppRadius.r10)
              ]
          ).paddingSymmetric(horizontal: Insets.i15)
        ]
    ).paddingSymmetric(vertical: Insets.i15).boxBorderExtension(context,radius: AppRadius.r12,isShadow: true);
  }
}
