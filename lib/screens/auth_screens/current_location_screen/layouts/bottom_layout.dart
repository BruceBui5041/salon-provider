import 'package:figma_squircle_updated/figma_squircle.dart';

import '../../../../config.dart';

class BottomLocationLayout extends StatelessWidget {
  const BottomLocationLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(builder: (context1, value, child) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonArrow(
                    arrow: rtl(context)
                        ? eSvgAssets.arrowRight
                        : eSvgAssets.arrowLeft)
                .inkWell(onTap: () => route.pop(context))
                .paddingSymmetric(vertical: Insets.i50, horizontal: Insets.i20),
            Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: Sizes.s40,
                    width: Sizes.s40,
                    margin: const EdgeInsets.symmetric(horizontal: Insets.i20),
                    decoration: ShapeDecoration(
                        color: appColor(context).appTheme.fieldCardBg,
                        shape: SmoothRectangleBorder(
                            borderRadius: SmoothBorderRadius(
                                cornerRadius: 8, cornerSmoothing: 1))),
                    child: SvgPicture.asset(
                      eSvgAssets.zipcode,
                      fit: BoxFit.scaleDown,
                      colorFilter: ColorFilter.mode(
                          appColor(context).appTheme.darkText, BlendMode.srcIn),
                    ),
                  ).inkWell(onTap: () => value.fetchCurrent(context)),
                ),
                const VSpace(Sizes.s20),
                Container(
                        child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(language(context, appFonts.selectService),
                            style: appCss.dmDenseRegular14.textColor(
                                appColor(context).appTheme.lightText)),
                      ]),
                  const VSpace(Sizes.s15),
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(eSvgAssets.location,
                                  colorFilter: ColorFilter.mode(
                                      appColor(context).appTheme.primary,
                                      BlendMode.srcIn))
                              .paddingAll(Insets.i7)
                              .decorated(
                                  color: appColor(context)
                                      .appTheme
                                      .primary
                                      .withOpacity(0.15),
                                  shape: BoxShape.circle),
                          const HSpace(Sizes.s12),
                          if (value.currentAddress != null &&
                              value.street != null)
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (value.currentAddress != null)
                                    Text(value.currentAddress!,
                                        style: appCss.dmDenseBold14.textColor(
                                            appColor(context)
                                                .appTheme
                                                .darkText)),
                                  const VSpace(Sizes.s8),
                                  SizedBox(
                                      width: Sizes.s200,
                                      child: Text(value.street!,
                                          style: appCss.dmDenseRegular12
                                              .textColor(appColor(context)
                                                  .appTheme
                                                  .lightText)))
                                ])
                        ])
                  ])
                      .paddingAll(Insets.i12)
                      .boxBorderExtension(context,
                          bColor: appColor(context).appTheme.fieldCardBg,
                          color: appColor(context).appTheme.fieldCardBg,
                          radius: AppRadius.r8)
                      .paddingOnly(bottom: Insets.i15),
                  ButtonCommon(
                    title: appFonts.confirmLocation,
                    onTap: () => value.onEdit(context),
                  )
                ]).paddingAll(Insets.i20))
                    .bottomSheetExtension(context),
              ],
            )
          ]);
    });
  }
}
