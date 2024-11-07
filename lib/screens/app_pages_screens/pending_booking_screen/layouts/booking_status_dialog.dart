import 'package:flutter/cupertino.dart';
import '../../../../config.dart';

class BookingStatusDialog extends StatelessWidget {
  const BookingStatusDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            height: Sizes.s470,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(language(context, appFonts.bookingStatus),
                    style: appCss.dmDenseMedium18
                        .textColor(appColor(context).appTheme.darkText)),
                const Icon(CupertinoIcons.multiply)
                    .inkWell(onTap: () => route.pop(context))
              ]).paddingSymmetric(horizontal: Insets.i20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                  Container(
                        height: Sizes.s46,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage(eImageAssets.bookingStatusBg))),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("\u2022 ${language(context, appFonts.bookingId)}",
                                  style: appCss.dmDenseMedium12.textColor(
                                      appColor(context).appTheme.primary)),
                              Text("#45896",
                                  style: appCss.dmDenseMedium14.textColor(
                                      appColor(context).appTheme.primary))
                            ]).paddingSymmetric(horizontal: Insets.i15))
                    .paddingOnly(top: Insets.i25, bottom: Insets.i20),
                  ...appArray.bookingStatus
                    .asMap()
                    .entries
                    .map((e) => StatusStepsLayout(
                        data: e.value,
                        index: e.key,
                        selectIndex: 0,
                        list: appArray.bookingStatus))
                    .toList()
              ]).paddingSymmetric(horizontal: Insets.i20),
                ),
              ),
            ]).paddingSymmetric(vertical: Insets.i20))
        .bottomSheetExtension(context);
  }
}
