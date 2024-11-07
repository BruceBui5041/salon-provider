import '../config.dart';

class ReviewBottomLayout extends StatelessWidget {
  final String? serviceName;
  final GestureTapCallback? onTap;
  const ReviewBottomLayout({super.key,this.serviceName,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      RichText(
          text: TextSpan(
              style: appCss.dmDenseRegular12
                  .textColor(appColor(context).appTheme.lightText),
              text: "${language(context, appFonts.serviceName)} : ",
              children: [
                TextSpan(
                    text: serviceName!,
                    style: appCss.dmDenseRegular12
                        .textColor(appColor(context).appTheme.darkText))
              ])),
      SvgPicture.asset(eSvgAssets.anchorArrowRight,
          colorFilter: ColorFilter.mode(
              appColor(context).appTheme.lightText, BlendMode.srcIn))
    ])
        .paddingAll(Insets.i12)
        .boxShapeExtension(color: appColor(context).appTheme.fieldCardBg).inkWell(onTap: onTap)
        .paddingOnly(bottom: Insets.i15);
  }
}
