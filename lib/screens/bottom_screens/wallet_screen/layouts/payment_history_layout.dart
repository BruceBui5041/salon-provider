import 'package:salon_provider/model/response/payment_response.dart';
import '../../../../config.dart';

class PaymentHistoryLayout extends StatelessWidget {
  final Payment data;
  final GestureTapCallback? onTap;

  const PaymentHistoryLayout({super.key, required this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    final serviceTitle =
        data.booking?.serviceVersions?.firstOrNull?.title ?? 'Payment';
    final amount =
        data.amount.toString().toCurrencyVnd(); // Convert cents to dollars
    final customer = data.user;
    final customerName = customer != null
        ? "${customer.firstname ?? ''} ${customer.lastname ?? ''}"
        : 'Unknown';

    return Column(children: [
      Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(
                    serviceTitle,
                    style: appCss.dmDenseMedium14
                        .textColor(appColor(context).appTheme.darkText),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const VSpace(Sizes.s5),
                  Text(amount,
                      style: appCss.dmDenseBold18
                          .textColor(appColor(context).appTheme.darkText))
                ])),
            if (data.booking?.id != null)
              BookingIdLayout(
                id: data.booking!.id!,
                transactionStatus: data.transactionStatus?.name ?? 'N/A',
              )
          ]),
      const VSpace(Sizes.s12),
      Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(appColor(context).appTheme.isDark
                      ? eImageAssets.bookingDetailBg
                      : eImageAssets.commissionBg),
                  fit: BoxFit.fill)),
          child: Column(children: [
            WalletRowLayout(id: "#${data.id ?? ''}", title: appFonts.paymentId),
            WalletRowLayout(
                id: data.paymentMethod?.name.capitalizeFirst() ?? 'N/A',
                title: appFonts.methodType),
            WalletRowLayout(
                id: data.transactionStatus?.name.capitalizeFirst() ?? 'N/A',
                title: appFonts.status)
          ]).padding(horizontal: Insets.i15, top: Insets.i15)),
      const VSpace(Sizes.s10),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          Container(
              height: Sizes.s36,
              width: Sizes.s36,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: appColor(context).appTheme.primary.withOpacity(0.1)),
              child: customer?.userProfile?.profilePictureUrl != null
                  ? ClipOval(
                      child: Image.network(
                        customer!.userProfile!.profilePictureUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const SizedBox(),
                      ),
                    )
                  : const SizedBox()),
          const HSpace(Sizes.s12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(language(context, appFonts.customer),
                style: appCss.dmDenseRegular12
                    .textColor(appColor(context).appTheme.lightText)),
            Text(customerName,
                style: appCss.dmDenseMedium13
                    .textColor(appColor(context).appTheme.darkText))
          ])
        ]),
        SvgPicture.asset(eSvgAssets.anchorArrowRight,
                height: Sizes.s12,
                width: Sizes.s12,
                colorFilter: ColorFilter.mode(
                    appColor(context).appTheme.primary, BlendMode.srcIn))
            .inkWell(onTap: onTap)
      ]).paddingAll(Insets.i12).boxBorderExtension(context,
          isShadow: true, bColor: appColor(context).appTheme.stroke)
    ])
        .paddingAll(Insets.i15)
        .boxBorderExtension(context,
            isShadow: true, bColor: appColor(context).appTheme.stroke)
        .paddingOnly(bottom: Insets.i25);
  }
}
