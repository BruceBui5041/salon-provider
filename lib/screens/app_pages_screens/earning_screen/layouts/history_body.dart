import 'package:figma_squircle_updated/figma_squircle.dart';

import '../../../../config.dart';

class HistoryBody extends StatelessWidget {
  const HistoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
            decoration: ShapeDecoration(
                color: appColor(context).appTheme.whiteBg,
                shape: const SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius.only(
                        topRight:
                            SmoothRadius(cornerRadius: 15, cornerSmoothing: 1),
                        topLeft: SmoothRadius(
                            cornerRadius: 15, cornerSmoothing: 1)))),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              HeadingRowCommon(
                  title: appFonts.history,
                  onTap: () =>
                      route.pushNamed(context, routeName.earningHistory)),
              const VSpace(Sizes.s15),
              ...appArray.historyList
                  .asMap()
                  .entries
                  .map((e) => HistoryLayout(data: e.value))
                  .toList()
            ])
                    .width(MediaQuery.of(context).size.width)
                    .padding(top: Insets.i15, horizontal: Insets.i20))
        .paddingOnly(top: 0.5)
        .decorated(
            color: appColor(context).appTheme.stroke,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppRadius.r15),
                topRight: Radius.circular(AppRadius.r15)))
        .paddingOnly(bottom: Sizes.s110);
  }
}
