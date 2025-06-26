import '../../../../config.dart';

class ServicemanListLayout extends StatelessWidget {
  final dynamic data;
  final List? list;
  final int? index;
  final bool? isDetail, isBorder, isCheck;
  final GestureTapCallback? onDelete, onEdit, onIconTap;

  const ServicemanListLayout(
      {Key? key,
      this.data,
      this.onDelete,
      this.index,
      this.list,
      this.isDetail = false,
      this.isBorder = false,
      this.onEdit,
      this.isCheck = false,
      this.onIconTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if this is a nearby location or current location
    final bool isNearbyLocation =
        data["subtext"] == language(context, appFonts.nearbyLocation) ||
            data["subtext"] == language(context, appFonts.currentLocation);

    return isBorder == true
        ? ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                leading: SvgPicture.asset(isCheck == true ? eSvgAssets.tick : eSvgAssets.location, colorFilter: ColorFilter.mode(isCheck == true ? appColor(context).appTheme.whiteColor : appColor(context).appTheme.primary, BlendMode.srcIn))
                    .paddingAll(Insets.i10)
                    .decorated(
                        shape: BoxShape.circle,
                        color: isCheck == true
                            ? appColor(context).appTheme.primary
                            : appColor(context)
                                .appTheme
                                .primary
                                .withOpacity(0.1))
                    .inkWell(onTap: onIconTap),
                title: Row(children: [
                  Text(language(context, data["title"]),
                          overflow: TextOverflow.ellipsis,
                          style: appCss.dmDenseMedium12
                              .textColor(appColor(context).appTheme.darkText))
                      .width(Sizes.s130)
                ]),
                subtitle: Text(language(context, data["subtext"]),
                    style: appCss.dmDenseMedium12
                        .textColor(appColor(context).appTheme.lightText)),
                trailing: isNearbyLocation
                    ? null
                    : Row(mainAxisSize: MainAxisSize.min, children: [
                        CommonArrow(
                            arrow: eSvgAssets.edit,
                            onTap: onEdit,
                            isThirteen: true),
                        const HSpace(Sizes.s10),
                        CommonArrow(
                            arrow: eSvgAssets.delete,
                            color:
                                appColor(context).appTheme.red.withOpacity(0.1),
                            svgColor: appColor(context).appTheme.red,
                            onTap: onDelete,
                            isThirteen: true)
                      ]))
            .paddingSymmetric(horizontal: Insets.i15)
            .boxBorderExtension(context,
                color: appColor(context).appTheme.whiteBg, isShadow: true)
            .paddingOnly(bottom: index != list!.length - 1 ? Insets.i15 : 0)
        : ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                leading: SvgPicture.asset(eSvgAssets.location, colorFilter: ColorFilter.mode(appColor(context).appTheme.primary, BlendMode.srcIn)).paddingAll(Insets.i10).decorated(
                    shape: BoxShape.circle,
                    color: appColor(context).appTheme.primary.withOpacity(0.1)),
                title: Row(children: [
                  Text(language(context, data["title"]),
                          overflow: TextOverflow.ellipsis,
                          style: appCss.dmDenseRegular12
                              .textColor(appColor(context).appTheme.darkText))
                      .width(Sizes.s130)
                ]),
                subtitle: Text(language(context, data["subtext"]),
                    style: appCss.dmDenseMedium12
                        .textColor(appColor(context).appTheme.lightText)),
                trailing: SvgPicture.asset(eSvgAssets.delete, colorFilter: ColorFilter.mode(appColor(context).appTheme.red, BlendMode.srcIn))
                    .paddingAll(Insets.i7)
                    .decorated(shape: BoxShape.circle, color: appColor(context).appTheme.red.withOpacity(0.1))
                    .inkWell(onTap: onDelete))
            .paddingSymmetric(horizontal: Insets.i15)
            .boxShapeExtension(color: isDetail == true ? appColor(context).appTheme.fieldCardBg : appColor(context).appTheme.whiteBg)
            .paddingOnly(bottom: index != list!.length - 1 ? Insets.i15 : 0);
  }
}
