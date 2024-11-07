import '../../../../config.dart';

class AvailableServiceLayout extends StatelessWidget {
  final dynamic data;
  final GestureTapCallback? onTap;

  const AvailableServiceLayout({super.key, this.data,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          height: Sizes.s100,
          width: MediaQuery.of(context).size.width,
          decoration: ShapeDecoration(
              image: DecorationImage(
                  image: AssetImage(data["image"]), fit: BoxFit.cover),
              shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius(
                      cornerRadius: 6, cornerSmoothing: 1)))),
      const VSpace(Sizes.s10),
      Text(data["title"],
          style: appCss.dmDenseMedium13
              .textColor(appColor(context).appTheme.darkText)),
      IntrinsicHeight(
          child: Row(mainAxisSize: MainAxisSize.min, children: [
        Text(data["service"],
            style: appCss.dmDenseRegular12
                .textColor(appColor(context).appTheme.lightText)),
        VerticalDivider(
                width: 1,
                color: appColor(context).appTheme.lightText,
                thickness: 1,
                indent: 3,
                endIndent: 3)
            .paddingSymmetric(horizontal: Insets.i4),
        Expanded(
          child: Text(data["year"],
              overflow: TextOverflow.ellipsis,
              style: appCss.dmDenseRegular12
                  .textColor(appColor(context).appTheme.lightText))
        )
      ])),
      const VSpace(Sizes.s12),
      Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: appArray.socialList
                  .asMap()
                  .entries
                  .map((e) => SocialLayout(
                      index: e.key, data: e.value, list: appArray.socialList))
                  .toList())
          .paddingSymmetric(horizontal: Insets.i10, vertical: Insets.i10)
          .boxShapeExtension(color: appColor(context).appTheme.fieldCardBg)
    ]).paddingAll(Insets.i12).boxBorderExtension(context, isShadow: true).inkWell(onTap: onTap);
  }
}
