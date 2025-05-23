import 'package:flutter/cupertino.dart';

import '../../../../config.dart';

class SelectServicemenSheet extends StatelessWidget {
  final int? arguments;
  const SelectServicemenSheet({super.key, this.arguments});

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<AcceptedBookingProvider>(context);
    return SizedBox(
            height: Sizes.s340,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(language(context, appFonts.selectServicemen),
                    style: appCss.dmDenseMedium18
                        .textColor(appColor(context).appTheme.darkText)),
                const Icon(CupertinoIcons.multiply)
                    .inkWell(onTap: () => route.pop(context))
              ]).paddingSymmetric(horizontal: Insets.i20),
              const VSpace(Sizes.s20),
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                Text(language(context, appFonts.chooseOne),
                    style: appCss.dmDenseMedium14
                        .textColor(appColor(context).appTheme.lightText)),
                const VSpace(Sizes.s10),
                Column(
                  children: [
                    ...appArray.selectServicemenList
                        .asMap()
                        .entries
                        .map((e) => SelectServicemenLayout(
                              amount: value.amountCtrl.text,
                              data: e.value,
                              selectIndex: value.selectIndex,
                              index: e.key,
                              list: appArray.selectServicemenList,
                              onTap: () => value.onServicemenChange(e.key)
                            ))
                  ]
                )
                    .paddingSymmetric(
                        vertical: Insets.i20, horizontal: Insets.i15)
                    .boxBorderExtension(context, isShadow: true)
              ]).paddingSymmetric(horizontal: Insets.i20))),
              const VSpace(Sizes.s30),
              ButtonCommon(title: appFonts.continues,onTap: ()=> value.onTapContinue(context, arguments)).paddingSymmetric(horizontal: Insets.i20)
            ]).paddingSymmetric(vertical: Insets.i20))
        .bottomSheetExtension(context);
  }
}
