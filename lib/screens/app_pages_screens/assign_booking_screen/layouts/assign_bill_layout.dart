import '../../../../config.dart';
import '../../../../model/response/booking_response.dart';

class AssignBillLayout extends StatelessWidget {
  final Booking? booking;
  const AssignBillLayout({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    if (booking == null) return const SizedBox();

    // Calculate total service price
    double totalServicePrice = 0;
    if (booking!.serviceVersions != null) {
      for (var service in booking!.serviceVersions!) {
        final discountedPrice =
            double.tryParse(service.discountedPrice ?? service.price ?? '0') ??
                0;
        totalServicePrice += discountedPrice;
      }
    }

    final coupon = booking!.coupon;
    final couponAmount = coupon != null && coupon.discountType == 'percentage'
        ? (totalServicePrice *
            (double.tryParse(coupon.discountValue!) ?? 0) /
            100)
        : (double.tryParse(coupon?.discountValue ?? '0') ?? 0);

    // Calculate commission
    final commission = booking!.commission;
    final commissionAmount = commission != null && commission.percentage != null
        ? (totalServicePrice * commission.percentage! / 100)
        : 0;

    final totalVersionDiscountedPrice = booking!.serviceVersions?.fold<double>(
            0,
            (sum, service) =>
                sum +
                (double.tryParse(
                        service.discountedPrice ?? service.price ?? '0') ??
                    0)) ??
        0;

    final earnings =
        totalVersionDiscountedPrice - commissionAmount + couponAmount;

    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              appColor(context).appTheme.isDark
                  ? eImageAssets.bookingDetailBg
                  : eImageAssets.pendingBillBg,
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(children: [
          // Service charges
          if (booking!.serviceVersions != null)
            ...booking!.serviceVersions!.expand((service) {
              final originalPrice = double.tryParse(service.price ?? '0') ?? 0;
              final discountedPrice = double.tryParse(
                      service.discountedPrice ?? service.price ?? '0') ??
                  0;
              final hasDiscount = service.discountedPrice != null &&
                  service.discountedPrice != service.price;

              return [
                BillRowCommon(
                  title: service.title ?? appFonts.perServiceCharge,
                  price: hasDiscount
                      ? discountedPrice.toString().toCurrencyVnd()
                      : originalPrice.toString().toCurrencyVnd(),
                  priceOriginal: hasDiscount
                      ? originalPrice.toString().toCurrencyVnd()
                      : null,
                  style: appCss.dmDenseMedium14
                      .textColor(appColor(context).appTheme.primary),
                ).paddingOnly(bottom: Insets.i10),
              ];
            }).toList(),

          Divider(
                  color: appColor(context).appTheme.stroke,
                  thickness: 1,
                  height: 1,
                  endIndent: 6,
                  indent: 6)
              .paddingOnly(bottom: Insets.i20),

          // Total amount
          BillRowCommon(
                  title: appFonts.totalAmount,
                  price: totalVersionDiscountedPrice.toString().toCurrencyVnd(),
                  styleTitle: appCss.dmDenseMedium14
                      .textColor(appColor(context).appTheme.darkText),
                  style: appCss.dmDenseBold16
                      .textColor(appColor(context).appTheme.primary))
              .paddingOnly(bottom: Insets.i10),

          // Coupon discount if any
          if (booking!.coupon != null && couponAmount > 0)
            BillRowCommon(
                    title: booking!.coupon?.code,
                    price: "+${couponAmount.toString().toCurrencyVnd()}",
                    style: appCss.dmDenseMedium14
                        .textColor(appColor(context).appTheme.red))
                .paddingSymmetric(vertical: Insets.i18),

          // platform fee amount
          BillRowCommon(
                  title: appFonts.platformFees,
                  price: "-${commissionAmount.toString().toCurrencyVnd()}",
                  styleTitle: appCss.dmDenseMedium14
                      .textColor(appColor(context).appTheme.darkText),
                  style: appCss.dmDenseBold16
                      .textColor(appColor(context).appTheme.red))
              .paddingOnly(bottom: Insets.i10),

          // Total earned
          BillRowCommon(
                  title: appFonts.earnings,
                  price: "+${earnings.toString().toCurrencyVnd()}",
                  styleTitle: appCss.dmDenseMedium14
                      .textColor(appColor(context).appTheme.darkText),
                  style: appCss.dmDenseBold16
                      .textColor(appColor(context).appTheme.online))
              .paddingOnly(bottom: Insets.i10),
        ]).paddingSymmetric(vertical: Insets.i20));
  }
}
