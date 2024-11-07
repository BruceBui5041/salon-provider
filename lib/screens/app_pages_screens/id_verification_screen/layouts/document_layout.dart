import 'package:flutter/cupertino.dart';

import '../../../../config.dart';

class DocumentLayout extends StatelessWidget {
  final dynamic data;
  final List? list;
  final int? index;
  const DocumentLayout({super.key,this.data,this.index,this.list});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Image.asset(data["image"],
          height: Sizes.s160, width: MediaQuery.of(context).size.width),
      const VSpace(Sizes.s12),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          if(language(context, data["status"]) == language(context, appFonts.requestForUpdate))
          Icon(CupertinoIcons.checkmark_alt_circle_fill,
              color: appColor(context).appTheme.online, size: Sizes.s18),
          if(language(context, data["status"]) == language(context, appFonts.requestForUpdate))
          const HSpace(Sizes.s5),
          Text(language(context, data["title"]),
              style: appCss.dmDenseMedium14
                  .textColor(appColor(context).appTheme.darkText)).width(Sizes.s80),
        ]).expanded(),
        language(context, data["status"]) == language(context, appFonts.requestForUpdate) ?  Row(
          children: [
            Text(language(context, "${data["status"]}"),
                style: appCss.dmDenseMedium12
                    .textColor(appColor(context).appTheme.primary)),
            const HSpace(Sizes.s5),
            SvgPicture.asset(eSvgAssets.anchorArrowRight,colorFilter: ColorFilter.mode(appColor(context).appTheme.primary, BlendMode.srcIn))
          ]
        ) :
        Text(language(context, "\u2022 ${language(context, data["status"])}"),
            style: appCss.dmDenseMedium12
                .textColor(appColor(context).appTheme.red))
      ])
          .paddingAll(Insets.i15)
          .boxBorderExtension(context, radius: AppRadius.r10,bColor: appColor(context).appTheme.stroke)
    ]).paddingAll(Insets.i12).boxShapeExtension(
        color: appColor(context).appTheme.fieldCardBg, radius: AppRadius.r10).paddingOnly(bottom: index != list!.length -1 ? Insets.i15 : 0 );
  }
}
