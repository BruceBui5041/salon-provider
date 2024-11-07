import 'package:flutter/cupertino.dart';
import '../../../../config.dart';

class SelectTimeSheet extends StatelessWidget {
  final GestureTapCallback? onTap;
  const SelectTimeSheet({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return Consumer<TimeSlotProvider>(builder: (context, value, child) {
        return SizedBox(
            height: MediaQuery.of(context).size.height * 0.58,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
                child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(language(context, appFonts.selectTime),
                    style: appCss.dmDenseblack18
                        .textColor(appColor(context).appTheme.darkText)),
                const Icon(CupertinoIcons.multiply)
                    .inkWell(onTap: () => route.pop(context))
              ]).paddingAll(Insets.i20),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SelectTimeWheelLayout(
                        childCount: 11,
                        controller: value.controller,
                        onSelectedItemChanged: (val) => value.onHourChange(val),
                        builder: (context, index) {
                          return HourLayout(
                              hours: index + 1,
                              index: index,
                              selectIndex: value.scrollHourIndex);
                        }),
                    const HSpace(Sizes.s12),
                    SelectTimeWheelLayout(
                        childCount: 59,
                        onSelectedItemChanged: (val) => value.onMinChange(val),
                        builder: (context, index) {
                          return MyMinutes(
                              index: index,
                              selectIndex: value.scrollMinIndex,
                              min: index + 1);
                        }),
                    const HSpace(Sizes.s12),
                    SelectTimeWheelLayout(
                        childCount: 2,
                        onSelectedItemChanged: (val) => value.onAmPmChange(val),
                        builder: (context, index) {
                          if (index == 0) {
                            return AmPmLayout(
                                index: index,
                                selectIndex: value.scrollDayIndex,
                                isItAm: true);
                          } else {
                            return AmPmLayout(
                                index: index,
                                selectIndex: value.scrollDayIndex,
                                isItAm: false);
                          }
                        })
                  ]).paddingSymmetric(horizontal: Insets.i20),
              ButtonCommon(title: appFonts.addTime,onTap: onTap)
                  .paddingSymmetric(horizontal: Insets.i20)
            ]))).bottomSheetExtension(context);
      });
    });
  }
}
