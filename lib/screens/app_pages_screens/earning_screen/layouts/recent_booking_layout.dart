import '../../../../config.dart';
import '../../../../model/recent_booking_model.dart';

class RecentBookingLayout extends StatelessWidget {
  final RecentBookingModel? data;
  final GestureTapCallback? onTap;

  const RecentBookingLayout({super.key, this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<DashboardProvider>(context, listen: true);
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(language(context, data!.name!),
              style: appCss.dmDenseMedium16
                  .textColor(appColor(context).appTheme.darkText)),
          Row(children: [
            Text(language(context, "\$${data!.price!}"),
                style: appCss.dmDenseBold18
                    .textColor(appColor(context).appTheme.primary)),
            const HSpace(Sizes.s8),
            if (data!.offer != null)
              Text(language(context, "(${data!.offer!})"),
                  style: appCss.dmDenseMedium14
                      .textColor(appColor(context).appTheme.red))
          ]),
          const VSpace(Sizes.s8),
          IntrinsicHeight(
            child: Row(children: [
              SvgPicture.asset(eSvgAssets.calender,
                  colorFilter: ColorFilter.mode(
                      appColor(context).appTheme.darkText, BlendMode.srcIn)),
              const HSpace(Sizes.s6),
              Text(language(context, data!.date!),
                  style: appCss.dmDenseMedium13
                      .textColor(appColor(context).appTheme.darkText)),
              VerticalDivider(
                      width: 1,
                      color: appColor(context).appTheme.stroke,
                      thickness: 1,
                      indent: 3,
                      endIndent: 3)
                  .paddingSymmetric(horizontal: Insets.i8),
              SvgPicture.asset(eSvgAssets.clock,
                  colorFilter: ColorFilter.mode(
                      appColor(context).appTheme.darkText, BlendMode.srcIn)),
              const HSpace(Sizes.s6),
              Text(language(context, data!.time!),
                  style: appCss.dmDenseMedium13
                      .textColor(appColor(context).appTheme.darkText))
            ]),
          ),
        ]),
        Container(
            height: Sizes.s84,
            width: Sizes.s84,
            decoration: ShapeDecoration(
                image: DecorationImage(
                    image: AssetImage(data!.image!), fit: BoxFit.cover),
                shape: const SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius.all(SmoothRadius(
                        cornerRadius: AppRadius.r10, cornerSmoothing: 1)))))
      ]),
      const VSpace(Sizes.s12),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(language(context, appFonts.requiredServiceman),
            style: appCss.dmDenseMedium12
                .textColor(appColor(context).appTheme.darkText)),
        const HSpace(Sizes.s8),
        Text(language(context, "${data!.serviceman!} ${appFonts.serviceman}"),
            style: appCss.dmDenseMedium14
                .textColor(appColor(context).appTheme.primary))
      ]),
      const DottedLines().paddingSymmetric(vertical: Insets.i12),
      Stack(alignment: Alignment.bottomCenter, children: [
        data!.servicemanLists!.isNotEmpty
            ? Column(children: [
                if (data!.servicemanLists!.isNotEmpty)
                  data!.isExpand == true
                      ? Column(
                          children:
                              data!.servicemanLists!.asMap().entries.map((s) {
                          return ServiceProviderLayout(
                              expand: data!.isExpand,
                              title: s.value.role,
                              image: s.value.image,
                              name: s.value.title,
                              rate: s.value.rate,
                              index: s.key,
                              list: data!.servicemanLists!);
                        }).toList())
                      : Column(
                          children: data!.servicemanLists!
                              .getRange(0, 1)
                              .toList()
                              .asMap()
                              .entries
                              .map((s) {
                          return ServiceProviderLayout(
                              expand: data!.isExpand,
                              title: s.value.role,
                              image: s.value.image,
                              name: s.value.title,
                              rate: s.value.rate,
                              index: s.key,
                              list: data!.servicemanLists!);
                        }).toList())
              ])
                .paddingSymmetric(horizontal: Insets.i15)
                .boxShapeExtension(
                    color: appColor(context).appTheme.fieldCardBg,
                    radius: AppRadius.r12)
                .paddingOnly(
                    bottom: data!.servicemanLists!.length > 1 ? Insets.i20 : 0)
            : Text(
                language(context,
                    "${appFonts.note}${appFonts.servicemanNotSelectedYet}"),
                style: appCss.dmDenseMedium12
                    .textColor(appColor(context).appTheme.lightText)
              ).alignment(Alignment.centerLeft),


        if (data!.servicemanLists != null)
          if (data!.servicemanLists!.length > 1)
            CommonArrow(
                arrow: data!.isExpand == true
                    ? eSvgAssets.upDoubleArrow
                    : eSvgAssets.downDoubleArrow,
                isThirteen: true,
                onTap: () => value.onExpand(data),
                color: appColor(context).appTheme.whiteBg)
      ])
    ])
        .paddingSymmetric(horizontal: Insets.i15, vertical: Insets.i20)
        .boxBorderExtension(context)
        .paddingOnly(bottom: Insets.i15)
        .inkWell(onTap: onTap);
  }
}
