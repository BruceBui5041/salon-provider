import '../../../../config.dart';

class ListTileLayout extends StatelessWidget {
  final CategoryModel? data;
  final dynamic booking;
  final bool? isBooking;
  final int? index;
  final GestureTapCallback? onTap;
  final List? selectedCategory;

  const ListTileLayout(
      {super.key,
      this.data,
      this.onTap,
      this.selectedCategory,
      this.booking,
      this.isBooking = false,
      this.index});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      IntrinsicHeight(
          child: Row(children: [
        isBooking == true
            ? SvgPicture.asset(booking["icon"],colorFilter: ColorFilter.mode(appColor(context).appTheme.darkText, BlendMode.srcIn))
            : data!.media != null && data!.media!.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: data!.media![0].originalUrl!,
                    imageBuilder: (context, imageProvider) => Container(
                        height: Sizes.s20,
                        width: Sizes.s20,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: imageProvider))),
                    errorWidget: (context, url, error) => Image.asset(
                        eImageAssets.appLogo,
                        height: Sizes.s20,
                        width: Sizes.s20))
                : Image.asset(eImageAssets.appLogo,
                    height: Sizes.s20, width: Sizes.s20),
        VerticalDivider(
                indent: 4,
                endIndent: 4,
                width: 1,
                color: appColor(context).appTheme.stroke)
            .paddingSymmetric(horizontal: Insets.i12),
        isBooking == true
            ? Text(language(context, booking["title"]),
                style: appCss.dmDenseMedium14
                    .textColor(appColor(context).appTheme.darkText))
            : Text(language(context, data!.title),
                style: appCss.dmDenseMedium14
                    .textColor(appColor(context).appTheme.darkText))
      ])),
      CheckBoxCommon(
          isCheck: isBooking == true
              ? selectedCategory!.contains(index)
              : selectedCategory!.contains(data!.id),
          onTap: onTap)
    ])
        .paddingSymmetric(vertical: Insets.i10, horizontal: Insets.i15)
        .boxBorderExtension(context, isShadow: true)
        .padding(horizontal: Insets.i20, bottom: Insets.i15);
  }
}
