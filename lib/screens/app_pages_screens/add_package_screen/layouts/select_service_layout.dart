import 'package:figma_squircle_updated/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import '../../../../config.dart';

class SelectServiceLayout extends StatelessWidget {
  final dynamic data;
  final GestureTapCallback? onTapCross;

  const SelectServiceLayout({super.key, this.onTapCross, this.data});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(alignment: Alignment.topRight, children: [
        Container(
            height: Sizes.s72,
            width: Sizes.s72,
            decoration: ShapeDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(data["icon"])),
                shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                        cornerRadius: AppRadius.r6, cornerSmoothing: 1)))),
        Container(
                padding: const EdgeInsets.all(Insets.i4),
                decoration: ShapeDecoration(
                    color: appColor(context).appTheme.darkText.withOpacity(0.5),
                    shape: const SmoothRectangleBorder(
                        borderRadius: SmoothBorderRadius.only(
                            bottomLeft: SmoothRadius(
                                cornerRadius: AppRadius.r6, cornerSmoothing: 1),
                            topRight: SmoothRadius(
                                cornerRadius: AppRadius.r6,
                                cornerSmoothing: 1)))),
                child: Icon(CupertinoIcons.multiply,
                    color: appColor(context).appTheme.whiteColor,
                    size: Sizes.s14))
            .inkWell(onTap: onTapCross)
      ]),
      const VSpace(Sizes.s6),
      Text(language(context, data["title"]),
              overflow: TextOverflow.ellipsis,
              style: appCss.dmDenseRegular12
                  .textColor(appColor(context).appTheme.darkText))
          .width(Sizes.s70)
    ]).paddingOnly(right: Insets.i12);
  }
}
