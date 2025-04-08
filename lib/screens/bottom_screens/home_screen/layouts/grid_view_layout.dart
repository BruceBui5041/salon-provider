import 'package:figma_squircle_updated/figma_squircle.dart';

import '../../../../config.dart';
import 'dart:math';

class GridViewLayout extends StatelessWidget {
  final Animation? animation;
  final dynamic data;
  final int? index;
  final GestureTapCallback? onTap;

  const GridViewLayout(
      {super.key, this.animation, this.data, this.index, this.onTap});

  @override
  Widget build(BuildContext context) {
    return StaggeredGridTile.count(
        crossAxisCellCount: index == 0
            ? 6
            : index == 1
                ? 4
                : index == 2
                    ? 4
                    : 6,
        mainAxisCellCount: 3.4,
        child: Container(
                decoration: ShapeDecoration(
                    color: appColor(context).appTheme.fieldCardBg,
                    image: DecorationImage(
                        image: AssetImage(eImageAssets.even1),
                        fit: BoxFit.cover),
                    shape: SmoothRectangleBorder(
                        borderRadius: SmoothBorderRadius(
                            cornerRadius: 15, cornerSmoothing: 1))),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RepaintBoundary(
                        child: Transform(
                          alignment: FractionalOffset.center,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.0015)
                            ..rotateY(pi * animation!.value),
                          child: SvgPicture.asset(data["image"]),
                        ),
                      ),
                      const VSpace(Sizes.s8),
                      Text(language(context, data["title"]),
                          overflow: TextOverflow.ellipsis,
                          style: appCss.dmDenseMedium12
                              .textColor(appColor(context).appTheme.lightText)),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${data["price"]}",
                                style: appCss.dmDenseBold16.textColor(
                                    appColor(context).appTheme.primary)),
                            SvgPicture.asset(eSvgAssets.anchorArrowRight,
                                colorFilter: ColorFilter.mode(
                                    appColor(context).appTheme.lightText,
                                    BlendMode.srcIn))
                          ])
                    ]).paddingAll(Insets.i15))
            .inkWell(onTap: onTap));
  }
}
