import '../../../../config.dart';

class CompletedBookingPaymentSummaryLayout extends StatelessWidget {
  const CompletedBookingPaymentSummaryLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage( appColor(context).appTheme.isDark ? eImageAssets.completedBg : eImageAssets.paymentSummary),
                fit: BoxFit.fill)),
        child: Column(children: [
          BillRowCommon(
              title: appFonts.paymentId, price: "#544"),
          BillRowCommon(
              title: appFonts.methodType,
              price: "Cash")
              .paddingSymmetric(vertical: Insets.i20),
          BillRowCommon(
              title: appFonts.status,
              price: "Paid",
              style: appCss.dmDenseMedium14.textColor(
                  appColor(context).appTheme.online)),
        ]).paddingSymmetric(
            vertical: Insets.i20));
  }
}
