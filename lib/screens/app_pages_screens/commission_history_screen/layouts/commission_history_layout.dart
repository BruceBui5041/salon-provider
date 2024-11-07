import '../../../../config.dart';

class CommissionHistoryLayout extends StatelessWidget {
  final dynamic data;
  final GestureTapCallback? onTap;

  const CommissionHistoryLayout({super.key, this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(children: [
              Text(language(context, appFonts.bookingId),
                  style: appCss.dmDenseMedium14
                      .textColor(appColor(context).appTheme.darkText)),
              const VSpace(Sizes.s6),
              Text(language(context, data["date"]),
                  style: appCss.dmDenseRegular12
                      .textColor(appColor(context).appTheme.lightText))
            ]),
            BookingIdLayout(id: data["bookingId"])
          ]).paddingAll(Insets.i12).boxBorderExtension(context,
              bColor: appColor(context).appTheme.stroke,
              color: appColor(context).appTheme.fieldCardBg, radius: AppRadius.r10),
          const VSpace(Sizes.s15),
          CommissionRowLayout(
              data: data["amount"],
              title: appFonts.totalReceivedCommission,
              style: appCss.dmDenseblack14
                  .textColor(appColor(context).appTheme.darkText)),
          CommissionRowLayout(
              title: appFonts.adminCommission, data: data["admin_commission"]),
          CommissionRowLayout(
              title: appFonts.servicemenCommission,
              data: data["servicemen_commission"]),
          CommissionRowLayout(
              title: appFonts.platformFees, data: data["platform_fees"]),
          CommissionRowLayout(
              title: appFonts.yourCommission,
              color: appColor(context).appTheme.primary,
              data: data["your_commission"])
        ]
      ).padding(horizontal: Insets.i15,top: Insets.i15),
      const DividerCommon().paddingOnly(bottom: Insets.i15),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(language(context, appFonts.viewMore),
            style: appCss.dmDenseMedium14
                .textColor(appColor(context).appTheme.primary)),
        SizedBox(
            height: Sizes.s18,
            width: Sizes.s18,
            child: SvgPicture.asset(eSvgAssets.anchorArrowRight,
                colorFilter: ColorFilter.mode(
                    appColor(context).appTheme.primary, BlendMode.srcIn)))
      ]).padding(horizontal: Insets.i15,bottom: Insets.i15)
    ])

        .boxBorderExtension(context, isShadow: true, radius: AppRadius.r12).inkWell(onTap: onTap)
        .paddingOnly(bottom: Insets.i15);
  }
}
