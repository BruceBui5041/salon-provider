import '../../../../config.dart';
import '../model/response/address_res.dart';

class SavedLocationLayout extends StatelessWidget {
  final Address? data;
  final List? list;
  final int? index;
  final String? type;
  final bool? isDetail, isBorder, isCheck;
  final GestureTapCallback? onIconTap, onEdit, onDelete;

  const SavedLocationLayout({
    super.key,
    this.data,
    this.index,
    this.list,
    this.type,
    this.isDetail = false,
    this.isBorder = false,
    this.isCheck = false,
    this.onIconTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    // Determine if this is a default location
    final bool isDefault = data?.isDefault == true;

    // Determine if this is a current location
    final bool isCurrent = type == "current";

    // Determine background color based on selection and type
    Color backgroundColor = appColor(context).appTheme.whiteBg;
    if (isCheck == true) {
      backgroundColor =
          appColor(context).appTheme.primary.withValues(alpha: 10);
    } else if (isCurrent) {
      backgroundColor =
          appColor(context).appTheme.primary.withValues(alpha: 15);
    } else if (isDefault) {
      backgroundColor =
          appColor(context).appTheme.accepted.withValues(alpha: 10);
    }

    Color? currentColor = isCurrent ? appColor(context).appTheme.primary : null;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      onTap: onIconTap,
      selectedColor: appColor(context).appTheme.primary,
      selected: isCurrent,
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
                  : appColor(context).appTheme.primary.withValues(alpha: 26))
          .inkWell(onTap: onIconTap),
      title: Text(
        data?.text ?? "",
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: appCss.dmDenseMedium12
            .textColor(appColor(context).appTheme.darkText),
      ),
      subtitle: Text(
        isCurrent
            ? (isDefault
                ? language(context, appFonts.currentLocation)
                    .toString()
                    .toUpperCase()
                : (data?.type ?? "").toUpperCase())
            : (isDefault
                ? language(context, appFonts.defaultLocation)
                : (data?.type ?? "")),
        style: appCss.dmDenseMedium12.textColor(isCurrent
            ? appColor(context).appTheme.primary
            : isDefault
                ? appColor(context).appTheme.accepted
                : appColor(context).appTheme.lightText),
      ),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        if (onEdit != null)
          CommonArrow(arrow: eSvgAssets.edit, onTap: onEdit, isThirteen: true),
        if (onEdit != null && onDelete != null) const HSpace(Sizes.s10),
        if (onDelete != null)
          CommonArrow(
              arrow: eSvgAssets.delete,
              color: appColor(context).appTheme.red.withValues(alpha: 26),
              svgColor: appColor(context).appTheme.red,
              onTap: onDelete,
              isThirteen: true)
      ]),
    )
        .paddingSymmetric(horizontal: Insets.i15)
        .boxBorderExtension(context,
            color: backgroundColor, isShadow: true, bColor: currentColor)
        .paddingOnly(bottom: index != list!.length - 1 ? Insets.i15 : 0);
  }
}
