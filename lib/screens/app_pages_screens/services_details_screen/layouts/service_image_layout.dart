import 'package:figma_squircle_updated/figma_squircle.dart';

import '../../../../config.dart';

class ServiceImageLayout extends StatelessWidget {
  final String? image, rating, title;
  final GestureTapCallback? editTap, deleteTap;
  const ServiceImageLayout(
      {super.key,
      this.rating,
      this.image,
      this.deleteTap,
      this.editTap,
      this.title});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
          padding: const EdgeInsets.only(
              left: Insets.i30, right: Insets.i30, top: Insets.i30),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: Sizes.s208,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.r20),
                  boxShadow: [
                    BoxShadow(
                        color: appColor(context)
                            .appTheme
                            .darkText
                            .withOpacity(0.2),
                        blurRadius: 8,
                        spreadRadius: 3)
                  ]))),
      Stack(children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: Sizes.s230,
            decoration: ShapeDecoration(
                image: DecorationImage(
                    image: AssetImage(image!), fit: BoxFit.cover),
                shape: const SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius.only(
                        bottomRight: SmoothRadius(
                            cornerRadius: AppRadius.r20, cornerSmoothing: 1),
                        bottomLeft: SmoothRadius(
                            cornerRadius: AppRadius.r20,
                            cornerSmoothing: 1))))),
        SizedBox(
                width: MediaQuery.of(context).size.width,
                height: Sizes.s230,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonArrow(
                                arrow: rtl(context)
                                    ? eSvgAssets.arrowRight
                                    : eSvgAssets.arrowLeft,
                                onTap: () => route.pop(context)),
                            Row(children: [
                              CommonArrow(
                                  arrow: eSvgAssets.edit,
                                  svgColor: appColor(context).appTheme.darkText,
                                  onTap: editTap),
                              const HSpace(Sizes.s15),
                              CommonArrow(
                                  arrow: eSvgAssets.delete,
                                  svgColor: appColor(context).appTheme.red,
                                  color: const Color(0xffFFEDED),
                                  onTap: deleteTap)
                            ])
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(title!,
                                style: appCss.dmDenseSemiBold18.textColor(
                                    appColor(context).appTheme.whiteColor)),
                            Row(children: [
                              SvgPicture.asset(eSvgAssets.star),
                              const HSpace(Sizes.s4),
                              Text(rating!,
                                  style: appCss.dmDenseMedium13.textColor(
                                      appColor(context).appTheme.whiteColor))
                            ])
                          ])
                    ]).padding(
                    horizontal: Insets.i20,
                    top: Insets.i50,
                    bottom: Insets.i20))
            .decorated(
                borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(AppRadius.r20),
                    right: Radius.circular(AppRadius.r20)),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      appColor(context).appTheme.trans,
                      appColor(context).appTheme.darkText.withOpacity(0.3)
                    ]))
      ])
    ]);
  }
}
