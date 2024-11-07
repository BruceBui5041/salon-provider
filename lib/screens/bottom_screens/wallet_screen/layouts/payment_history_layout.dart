import 'package:fixit_provider/model/payment_history_model.dart';

import '../../../../config.dart';

class PaymentHistoryLayout extends StatelessWidget {
    final PaymentHistoryModel? data;
    final GestureTapCallback? onTap;
  const PaymentHistoryLayout({super.key, this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(data!.title!,
                  style: appCss.dmDenseMedium14
                      .textColor(appColor(context).appTheme.darkText)),
              const VSpace(Sizes.s5),
              Text("\$${data!.price}",
                  style: appCss.dmDenseBold18
                      .textColor(appColor(context).appTheme.darkText))
            ]),
             BookingIdLayout(id: data!.bookingId)
          ]),
      const VSpace(Sizes.s12),
      Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage( appColor(context).appTheme.isDark ? eImageAssets.bookingDetailBg : eImageAssets.commissionBg),
                  fit: BoxFit.fill)),
          child: Column(children: [
             WalletRowLayout(id: "#${data!.paymentId}", title: appFonts.paymentId),
             WalletRowLayout(id: data!.methodType, title: appFonts.methodType),
            WalletRowLayout(id: data!.status, title: appFonts.status)
          ]).padding(horizontal: Insets.i15, top: Insets.i15)),
      const VSpace(Sizes.s10),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          Container(
              height: Sizes.s36,
              width: Sizes.s36,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage(data!.customer!.image!)))),
          const HSpace(Sizes.s12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(language(context, appFonts.customer),
                style: appCss.dmDenseRegular12
                    .textColor(appColor(context).appTheme.lightText)),
            Text(data!.customer!.title!,
                style: appCss.dmDenseMedium13
                    .textColor(appColor(context).appTheme.darkText))
          ])
        ]),
        SvgPicture.asset(eSvgAssets.anchorArrowRight,
            height: Sizes.s12,
            width: Sizes.s12,
            colorFilter: ColorFilter.mode(
                appColor(context).appTheme.primary, BlendMode.srcIn)).inkWell(onTap: onTap)
      ]).paddingAll(Insets.i12).boxBorderExtension(context, isShadow: true, bColor: appColor(context).appTheme.stroke)
    ]).paddingAll(Insets.i15).boxBorderExtension(context, isShadow: true, bColor: appColor(context).appTheme.stroke).paddingOnly(bottom: Insets.i25);
  }
}
