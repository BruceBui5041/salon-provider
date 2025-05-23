import 'dart:ui';

import 'package:figma_squircle_updated/figma_squircle.dart';
import 'package:salon_provider/widgets/cache_image.dart';

import '../../../../config.dart';

class ServicesImageLayout extends StatelessWidget {
  final dynamic data;
  final int? index, selectIndex;
  final GestureTapCallback? onTap;
  const ServicesImageLayout(
      {super.key, this.data, this.selectIndex, this.index, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.s60,
      width: Sizes.s60,
      decoration: ShapeDecoration(
          shape: SmoothRectangleBorder(
              side: BorderSide(
                  color: selectIndex == index
                      ? appColor(context).appTheme.primary
                      : appColor(context).appTheme.trans),
              borderRadius: SmoothBorderRadius(
                  cornerRadius: AppRadius.r8, cornerSmoothing: 1))),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.r6),
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(
              sigmaX: selectIndex == index ? 0.1 : 1.0,
              sigmaY: selectIndex == index ? 0.1 : 1.0),
          // child: Image.asset(data,
          //     height: Sizes.s60, width: Sizes.s60, fit: BoxFit.cover),
          child: CacheImageWidget(
            url: data,
          ),
        ),
      ),
    ).inkWell(onTap: onTap).paddingOnly(right: Insets.i15);
  }
}
