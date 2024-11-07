import '../config.dart';

class HeadingRowCommon extends StatelessWidget {
  final String? title;
  final GestureTapCallback? onTap;
  const HeadingRowCommon({super.key,this.title,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: Sizes.s200,
            child: Text(language(context,  title!),overflow: TextOverflow.ellipsis,style: appCss.dmDenseBold18.textColor(appColor(context).appTheme.darkText))),
        Text(language(context,  appFonts.viewAll),style: appCss.dmDenseRegular14.textColor(appColor(context).appTheme.primary)).inkWell(onTap: onTap)
      ]
    );
  }
}
