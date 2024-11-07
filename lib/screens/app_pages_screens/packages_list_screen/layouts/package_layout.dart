import '../../../../config.dart';

class PackageLayout extends StatelessWidget {
  final dynamic data;
  final ValueChanged<bool>? onToggle;
  final GestureTapCallback? onDelete,onEdit;
  const PackageLayout({super.key,this.data,this.onToggle, this.onDelete, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                  height: Sizes.s60,
                  width: Sizes.s60,
                  child: Image.asset(data["image"],
                      height: Sizes.s60, width: Sizes.s60, fit: BoxFit.cover)),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(language(context, data["title"]),
                    overflow: TextOverflow.ellipsis,
                    style: appCss.dmDenseMedium16
                        .textColor(appColor(context).appTheme.darkText)),
                const VSpace(Sizes.s3),
                Text(language(context, "\$${data["price"]}"),
                    style: appCss.dmDenseblack16
                        .textColor(appColor(context).appTheme.online)),
              ]).padding(top: Insets.i5, horizontal: Insets.i12)
            ]),
            Row(mainAxisSize: MainAxisSize.min, children: [
              CommonArrow(
                  arrow: eSvgAssets.edit, onTap: onEdit, isThirteen: true),
              const HSpace(Sizes.s10),
              CommonArrow(
                  arrow: eSvgAssets.delete,
                  color: appColor(context).appTheme.red.withOpacity(0.1),
                  svgColor: appColor(context).appTheme.red,
                  onTap: onDelete,
                  isThirteen: true)
            ])
          ]).paddingOnly(top: Insets.i17),
      IntrinsicHeight(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        PackageDetailRowLayout(title: appFonts.startDate, subtext: data["startDate"]),
        const PackageVerticalDivider(),
        PackageDetailRowLayout(title: appFonts.endDate, subtext: data["expiryDate"]),
        const PackageVerticalDivider(),
        PackageDetailRowLayout(title: appFonts.serviceIncluded, subtext: data["serviceIncluded"])
      ])),
      const DottedLines(),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(language(context, appFonts.activeStatus),
            style: appCss.dmDenseMedium12
                .textColor(appColor(context).appTheme.primary)),
        FlutterSwitchCommon(value: data["status"], onToggle: onToggle)
      ]).paddingOnly(top: Insets.i14, bottom: Insets.i17)
    ])
        .paddingSymmetric(horizontal: Insets.i15)
        .boxBorderExtension(context, isShadow: true,bColor: appColor(context).appTheme.stroke)
        .paddingOnly(bottom: Insets.i15).inkWell(onTap: ()=> route.pushNamed(context, routeName.packageDetails));
  }
}
