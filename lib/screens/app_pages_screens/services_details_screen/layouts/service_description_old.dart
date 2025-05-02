import '../../../../config.dart';

class ServiceDescriptionOld extends StatelessWidget {
  const ServiceDescriptionOld({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
            child: DescriptionLayoutCommon(
                icon: eSvgAssets.clock,
                title: appFonts.duration,
                subtitle: "45 minute")),
        Container(
                height: Sizes.s78,
                width: 1,
                color: appColor(context).appTheme.stroke)
            .paddingSymmetric(horizontal: Insets.i20),
        Expanded(
            child: DescriptionLayoutCommon(
                icon: eSvgAssets.category,
                title: appFonts.category,
                subtitle: "Ac repairing"))
      ]).paddingSymmetric(horizontal: Insets.i25),
      Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: appColor(context).appTheme.stroke),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
            child: DescriptionLayoutCommon(
                icon: eSvgAssets.commission,
                title: appFonts.commission,
                subtitle: "30%")),
        Container(
                height: Sizes.s78,
                width: 1,
                color: appColor(context).appTheme.stroke)
            .paddingSymmetric(horizontal: Insets.i20),
        Expanded(
            child: DescriptionLayoutCommon(
                icon: eSvgAssets.receiptDiscount,
                title: appFonts.tax,
                subtitle: "2%"))
      ]).paddingSymmetric(horizontal: Insets.i25),
      Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: appColor(context).appTheme.stroke),
      const VSpace(Sizes.s17),
      DescriptionLayoutCommon(
              isExpanded: true,
              icon: eSvgAssets.tagUser,
              title: appFonts.noOfRequired,
              subtitle: "2 servicemen")
          .paddingSymmetric(horizontal: Insets.i25),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(language(context, appFonts.description),
            style: appCss.dmDenseMedium12
                .textColor(appColor(context).appTheme.lightText)),
        const VSpace(Sizes.s6),
        const ReadMoreLayout(
            text:
                "Our expert technicians will thoroughly clean and disinfect your air conditioning system, ensuring optimal "),
        const VSpace(Sizes.s20),
        ServiceAreaLayout(
            onTapAdd: () => route.pushNamed(context, routeName.locationList)),
        const VSpace(Sizes.s15),
        Text("\u2022 Foamjet tachnology removes dust 2x deeper.",
            style: appCss.dmDenseMedium13
                .textColor(appColor(context).appTheme.lightText))
      ])
          .paddingSymmetric(horizontal: Insets.i20)
          .paddingSymmetric(vertical: Insets.i20)
    ]).boxBorderExtension(context, isShadow: true);
  }
}
