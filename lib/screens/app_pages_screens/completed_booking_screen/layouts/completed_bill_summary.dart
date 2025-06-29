import '../../../../config.dart';
import '../../../../model/response/booking_response.dart';
import '../../../../common/fee_type.dart';
import '../../../../model/response/fee_res.dart';

class CompletedBillSummary extends StatelessWidget {
  final Booking? booking;
  const CompletedBillSummary({super.key, required this.booking});

  // Calculate travel fee amount
  double _calculateTravelFeeAmount(Booking? booking) {
    if (booking?.fees != null && booking!.fees!.isNotEmpty) {
      final travelFee = booking.fees!.firstWhere(
        (fee) => fee.type == FeeType.travelFeePerKm,
        orElse: () => Fee(
          id: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          status: '',
          travelFeePerKm: null,
        ),
      );

      if (travelFee.travelFeePerKm != null) {
        // Calculate actual charged fee if we have distance info
        if (booking.bookingLocation?.initialDistance != null) {
          // Get the distance in km (initialDistance is in meters)
          double distanceInKm =
              booking.bookingLocation!.initialDistance! / 1000.0;

          // Parse the fee per km as double
          double? feePerKm = double.tryParse(travelFee.travelFeePerKm!);

          if (feePerKm != null) {
            // Check if free travel applies
            double freeTravelThreshold = 0.0;
            if (travelFee.freeTravelFeeAt != null) {
              freeTravelThreshold =
                  double.tryParse(travelFee.freeTravelFeeAt!) ?? 0.0;
            }

            // Calculate the charged fee based on the distance exceeding the free threshold
            if (distanceInKm > freeTravelThreshold) {
              // Only charge for distance beyond the free threshold
              double chargeableDistance = distanceInKm - freeTravelThreshold;
              double chargedFee = feePerKm * chargeableDistance;
              return chargedFee;
            }
          }
        }
      }
    }
    return 0.0;
  }

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

    // Calculate travel fee
    final travelFeeAmount = _calculateTravelFeeAmount(booking);

    final totalVersionDiscountedPrice = booking!.serviceVersions?.fold<double>(
            0,
            (sum, service) =>
                sum +
                (double.tryParse(
                        service.discountedPrice ?? service.price ?? '0') ??
                    0)) ??
        0;

    final earnings = totalVersionDiscountedPrice -
        commissionAmount +
        couponAmount +
        travelFeeAmount;

    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              appColor(context).appTheme.isDark
                  ? eImageAssets.completedBg
                  : eImageAssets.paymentSummary,
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
            }),

          // Travel fee if any
          if (travelFeeAmount > 0)
            BillRowCommon(
                    title: language(context, appFonts.travelFee),
                    price:
                        "+${travelFeeAmount.toStringAsFixed(0).toCurrencyVnd()}",
                    style: appCss.dmDenseMedium14
                        .textColor(appColor(context).appTheme.primary))
                .paddingOnly(bottom: Insets.i10),

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
                  price: (totalVersionDiscountedPrice + travelFeeAmount)
                      .toString()
                      .toCurrencyVnd(),
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
              .paddingOnly(bottom: Insets.i16),
          Divider(
                  color: appColor(context).appTheme.stroke,
                  thickness: 1,
                  height: 1,
                  endIndent: 6,
                  indent: 6)
              .paddingOnly(bottom: Insets.i10, top: Insets.i16),
          // Total earned
          BillRowCommon(
                  title: appFonts.earnings,
                  price: "+${earnings.toString().toCurrencyVnd()}",
                  styleTitle: appCss.dmDenseMedium14
                      .textColor(appColor(context).appTheme.primary),
                  style: appCss.dmDenseBold16
                      .textColor(appColor(context).appTheme.online))
              .paddingOnly(bottom: Insets.i10),
        ]).paddingSymmetric(vertical: Insets.i20));
  }
}
