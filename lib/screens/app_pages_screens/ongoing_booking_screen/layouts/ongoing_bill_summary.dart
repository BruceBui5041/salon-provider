import '../../../../config.dart';

class OngoingBillSummary extends StatelessWidget {
  const OngoingBillSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage( appColor(context).appTheme.isDark ? eImageAssets.completedBillBg : eImageAssets.ongoingBg),
                fit: BoxFit.fill)),
        child: Column(children: [
          BillRowCommon(title: appFonts.perServiceCharge, price: "\$12.00"),
          BillRowCommon(
                  title: "2 servicemen (\$12.00*2)",
                  price: "\$24.00",
                  style: appCss.dmDenseBold14
                      .textColor(appColor(context).appTheme.darkText))
              .paddingSymmetric(vertical: Insets.i20),
          BillRowCommon(
              title: "Extra service charge (\$20*1)",
              price: "\$20.00",
              style: appCss.dmDenseBold14
                  .textColor(appColor(context).appTheme.darkText)),
          const VSpace(Sizes.s20),
          BillRowCommon(
              title: appFonts.tax,
              price: "+\$12.00",
              color: appColor(context).appTheme.online),
          BillRowCommon(
                  title: appFonts.platformFees,
                  price: "+\$8.00",
                  color: appColor(context).appTheme.online)
              .padding(top: Insets.i20, bottom: Insets.i22),
          const DottedLines()
              .padding(bottom: Insets.i23, horizontal: Insets.i5),
          BillRowCommon(
              title: appFonts.totalAmount,
              price: "\$10.40",
              styleTitle: appCss.dmDenseMedium14
                  .textColor(appColor(context).appTheme.darkText),
              style: appCss.dmDenseBold14
                  .textColor(appColor(context).appTheme.darkText)),
          BillRowCommon(
                  title: appFonts.advancePaid,
                  price: "-\$5.80",
                  color: appColor(context).appTheme.red)
              .paddingOnly(top: Insets.i20, bottom: Insets.i26),
          Divider(
                  color: appColor(context).appTheme.stroke,
                  thickness: 1,
                  height: 1,
                  endIndent: 6,
                  indent: 6)
              .paddingOnly(bottom: Insets.i20),
          BillRowCommon(
                  title: appFonts.payableAmount,
                  price: "+\$36.00",
                  styleTitle: appCss.dmDenseMedium14
                      .textColor(appColor(context).appTheme.primary),
                  style: appCss.dmDenseBold16
                      .textColor(appColor(context).appTheme.primary))
              .paddingOnly(bottom: Insets.i10)
        ]).paddingSymmetric(vertical: Insets.i20));
  }
}
