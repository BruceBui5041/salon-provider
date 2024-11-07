import '../../../../config.dart';

class AcceptBillSummary extends StatelessWidget {
  const AcceptBillSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(appColor(context).appTheme.isDark ? eImageAssets.bookingDetailBg : eImageAssets.pendingBillBg),
                fit: BoxFit.fill)),
        child: Column(children: [
          BillRowCommon(
              title: appFonts.perServiceCharge,
              price: "\$12.00"),
          BillRowCommon(
              title: "2 servicemen (\$12.00*2)",
              price: "\$24.00",
              style: appCss.dmDenseBold14.textColor(
                  appColor(context).appTheme.darkText))
              .paddingSymmetric(vertical: Insets.i20),
          BillRowCommon(
              title: appFonts.tax,
              price: "+\$12.00",
              color: appColor(context).appTheme.online),
          BillRowCommon(
              title: appFonts.platformFees,
              price: "+\$8.00",
              color: appColor(context).appTheme.online)
              .paddingSymmetric(vertical: Insets.i20),
          Divider(
              color: appColor(context).appTheme.stroke,
              thickness: 1,
              height: 1,
              indent: 6,
              endIndent: 6)
              .paddingOnly(bottom: Insets.i23),
          BillRowCommon(
              title: appFonts.totalAmount,
              price: "\$10.40",
              styleTitle: appCss.dmDenseMedium14.textColor(
                  appColor(context).appTheme.darkText),
              style: appCss.dmDenseBold16.textColor(
                  appColor(context).appTheme.primary))
        ]).paddingSymmetric(vertical: Insets.i20));
  }
}
