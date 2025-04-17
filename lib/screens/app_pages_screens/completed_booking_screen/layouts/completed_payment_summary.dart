import '../../../../config.dart';
import '../../../../model/response/booking_response.dart';

class CompletedPaymentSummary extends StatelessWidget {
  final Booking? booking;
  const CompletedPaymentSummary({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    if (booking == null || booking!.payment == null) return const SizedBox();

    final payment = booking!.payment!;

    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(appColor(context).appTheme.isDark
                    ? eImageAssets.completedBg
                    : eImageAssets.paymentSummary),
                fit: BoxFit.fill)),
        child: Column(children: [
          BillRowCommon(title: appFonts.paymentId, price: "#${payment.id}"),
          BillRowCommon(
                  title: appFonts.methodType,
                  price:
                      payment.paymentMethod?.value.capitalizeFirst() ?? "N/A")
              .paddingSymmetric(vertical: Insets.i20),
          BillRowCommon(
              title: appFonts.status,
              price:
                  payment.transactionStatus?.value.capitalizeFirst() ?? "N/A",
              style: appCss.dmDenseMedium14
                  .textColor(appColor(context).appTheme.online)),
        ]).paddingSymmetric(vertical: Insets.i20));
  }
}
