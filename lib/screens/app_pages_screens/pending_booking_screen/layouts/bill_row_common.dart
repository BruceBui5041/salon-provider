import '../../../../config.dart';

class BillRowCommon extends StatelessWidget {
  final String? title, price, priceOriginal;
  final Color? color;
  final TextStyle? style, styleTitle;
  const BillRowCommon({
    super.key,
    this.title,
    this.price,
    this.color,
    this.style,
    this.styleTitle,
    this.priceOriginal,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(language(context, title!),
            style: styleTitle ??
                appCss.dmDenseMedium14
                    .textColor(appColor(context).appTheme.lightText)),
        Row(
          children: [
            if (priceOriginal != null)
              Text(
                priceOriginal!,
                style: (style ??
                        appCss.dmDenseMedium14.textColor(
                            color ?? appColor(context).appTheme.darkText))
                    .copyWith(
                        decoration: TextDecoration.lineThrough, fontSize: 12),
              ).paddingOnly(right: Insets.i8),
            Text(price!,
                style: style ??
                    appCss.dmDenseMedium14.textColor(
                        color ?? appColor(context).appTheme.darkText))
          ],
        ),
      ],
    ).paddingSymmetric(horizontal: Insets.i15);
  }
}
