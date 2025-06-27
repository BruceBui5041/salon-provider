import '../../../../config.dart';
import '../model/response/address_res.dart';

class NearLocationLayout extends StatelessWidget {
  final Address? data;
  final int? index;
  final bool? isDetail, isBorder, isCheck;
  final GestureTapCallback? onIconTap;

  const NearLocationLayout(
      {super.key,
      this.data,
      this.index,
      this.isDetail = false,
      this.isBorder = false,
      this.isCheck = false,
      this.onIconTap});

  @override
  Widget build(BuildContext context) {
    // Determine background color based on selection
    Color backgroundColor = appColor(context).appTheme.whiteBg;

    if (isCheck == true) {
      backgroundColor =
          appColor(context).appTheme.primary.withValues(alpha: 10);
    } else if (isDetail == true) {
      backgroundColor = appColor(context).appTheme.fieldCardBg;
    }

    return isBorder == true
        ? ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            onTap: onIconTap,
            leading: SvgPicture.asset(
                    isCheck == true ? eSvgAssets.tick : eSvgAssets.location,
                    colorFilter: ColorFilter.mode(
                        isCheck == true
                            ? appColor(context).appTheme.whiteColor
                            : appColor(context).appTheme.primary,
                        BlendMode.srcIn))
                .paddingAll(Insets.i10)
                .decorated(
                    shape: BoxShape.circle,
                    color: isCheck == true
                        ? appColor(context).appTheme.primary
                        : appColor(context)
                            .appTheme
                            .primary
                            .withValues(alpha: 26))
                .inkWell(onTap: onIconTap),
            title: Text(
              data?.text ?? "",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: appCss.dmDenseMedium12
                  .textColor(appColor(context).appTheme.darkText),
            ),
            subtitle: Text(
              language(context, appFonts.nearbyLocation),
              style: appCss.dmDenseMedium12
                  .textColor(appColor(context).appTheme.lightText),
            ),
          )
            .paddingSymmetric(horizontal: Insets.i15)
            .boxBorderExtension(context, color: backgroundColor, isShadow: true)
            .paddingOnly(bottom: Insets.i15)
        : ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            onTap: onIconTap,
            leading: SvgPicture.asset(eSvgAssets.location,
                    colorFilter: ColorFilter.mode(
                        appColor(context).appTheme.primary, BlendMode.srcIn))
                .paddingAll(Insets.i10)
                .decorated(
                    shape: BoxShape.circle,
                    color: appColor(context)
                        .appTheme
                        .primary
                        .withValues(alpha: 26))
                .inkWell(onTap: onIconTap),
            title: Text(
              data?.text ?? "",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: appCss.dmDenseRegular12
                  .textColor(appColor(context).appTheme.darkText),
            ),
            subtitle: Text(
              index == 0
                  ? language(context, appFonts.currentLocation)
                  : language(context, appFonts.nearbyLocation),
              style: appCss.dmDenseMedium12
                  .textColor(appColor(context).appTheme.lightText),
            ),
          )
            .paddingSymmetric(horizontal: Insets.i15)
            .boxShapeExtension(color: backgroundColor)
            .paddingOnly(bottom: Insets.i15);
  }
}
