import '../../../../config.dart';

class CategoriesListLayout extends StatelessWidget {
  final dynamic data;
  final GestureTapCallback? onTap;
  final bool? isCommission;
  const CategoriesListLayout({super.key,this.data,this.onTap,this.isCommission = false});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            SvgPicture.asset(data!.media![0].originalUrl!,fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(appColor(context).appTheme.darkText, BlendMode.srcIn),
                height: Sizes.s22, width: Sizes.s22),
            const HSpace(Sizes.s15),
            Row(
              children: [
                Text(language(context, data!.title),style: appCss.dmDenseRegular14.textColor(appColor(context).appTheme.darkText)),
                if(isCommission == true)
                Text(language(context, " - ${data!.commission!}%"),style: appCss.dmDenseRegular14.textColor(appColor(context).appTheme.darkText))
              ]
            )
          ]),
          SvgPicture.asset(rtl(context) ? eSvgAssets.arrowLeft : eSvgAssets.arrowRight,colorFilter: ColorFilter.mode(appColor(context).appTheme.lightText, BlendMode.srcIn))
        ]
    ).paddingAll(Insets.i15).boxBorderExtension(context,isShadow: true).inkWell(onTap: onTap).paddingOnly(bottom: Insets.i12);
  }
}
