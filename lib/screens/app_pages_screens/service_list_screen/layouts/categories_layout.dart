import '../../../../config.dart';

class TopCategoriesLayout extends StatelessWidget {
  final CategoryModel? data;
  final GestureTapCallback? onTap;
  final int? index, selectedIndex;
  final double? rPadding;
  final bool? isCategories;

  const TopCategoriesLayout(
      {super.key,
        this.onTap,
        this.data,
        this.index,
        this.selectedIndex,
        this.isCategories = false,
        this.rPadding});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          decoration: ShapeDecoration(
              color: selectedIndex == index
                  ? appColor(context).appTheme.primary.withOpacity(0.2)
                  : isCategories == true ? appColor(context).appTheme.fieldCardBg : appColor(context).appTheme.whiteBg ,
              shape: SmoothRectangleBorder(
                  side: BorderSide(
                      color: selectedIndex == index
                          ? appColor(context).appTheme.primary
                          : appColor(context).appTheme.trans),
                  borderRadius: SmoothBorderRadius(
                      cornerRadius: AppRadius.r10, cornerSmoothing: 1))),
          child: data!.media != null && data!.media!.isNotEmpty
              ?  SvgPicture.asset(data!.media![0].originalUrl!,
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(selectedIndex == index
                      ? appColor(context).appTheme.primary
                      : appColor(context).appTheme.darkText, BlendMode.srcIn),
                  height: Sizes.s22,
                  width: Sizes.s22)
              .paddingAll(Insets.i18) : Container()),
      const VSpace(Sizes.s8),
      Text(data!.title!,
          textAlign: TextAlign.center,
          style: appCss.dmDenseRegular14.textColor(selectedIndex == index
              ? appColor(context).appTheme.primary
              : appColor(context).appTheme.darkText))
    ]).inkWell(onTap: onTap).paddingOnly(right: rPadding ?? 0);
  }
}