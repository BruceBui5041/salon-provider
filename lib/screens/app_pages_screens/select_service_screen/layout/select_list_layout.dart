import 'package:figma_squircle_updated/figma_squircle.dart';

import '../../../../config.dart';

class SelectListLayout extends StatelessWidget {
  final dynamic data;
  final List? selectedCategory;
  final GestureTapCallback? onTap;

  const SelectListLayout(
      {super.key, this.data, this.selectedCategory, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(children: [
        Container(
            height: Sizes.s40,
            width: Sizes.s40,
            decoration: ShapeDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(data["icon"])),
                shape: const SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius.all(SmoothRadius(
                        cornerRadius: AppRadius.r8, cornerSmoothing: 1))))),
        const HSpace(Sizes.s12),
        Text(language(context, data["title"]),
            style: appCss.dmDenseMedium15
                .textColor(appColor(context).appTheme.darkText))
      ]),
      CheckBoxCommon(
          isCheck: selectedCategory!.contains(data["id"]), onTap: onTap)
    ])
        .paddingSymmetric(vertical: Insets.i12, horizontal: Insets.i15)
        .boxBorderExtension(context,
            radius: AppRadius.r10, bColor: appColor(context).appTheme.stroke)
        .paddingOnly(bottom: Insets.i15);
  }
}
