import 'package:figma_squircle_updated/figma_squircle.dart';

import '../config.dart';

class ViewLocationCommon extends StatelessWidget {
  final GestureTapCallback? onTapArrow;
  const ViewLocationCommon({super.key, this.onTapArrow});

  @override
  Widget build(BuildContext context) {
    return Container(
            decoration: ShapeDecoration(
                color: appColor(context).appTheme.primary.withOpacity(0.15),
                shape: const SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius.only(
                        bottomRight: SmoothRadius(
                            cornerRadius: AppRadius.r8, cornerSmoothing: 1),
                        bottomLeft: SmoothRadius(
                            cornerRadius: AppRadius.r8, cornerSmoothing: 1)))),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      language(context, appFonts.viewLocationOnMap)
                          .toUpperCase(),
                      style: appCss.dmDenseMedium12
                          .textColor(appColor(context).appTheme.primary)),
                  ArrowRightCommon(onTap: onTapArrow)
                ]).padding(
                horizontal: Insets.i15, top: Insets.i13, bottom: Insets.i11))
        .inkWell(onTap: () => route.pushNamed(context, routeName.viewLocation));
  }
}
