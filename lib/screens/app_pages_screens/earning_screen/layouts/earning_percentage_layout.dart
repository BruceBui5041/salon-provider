import '../../../../config.dart';

class EarningPercentageLayout extends StatelessWidget {
  const EarningPercentageLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
          height: Sizes.s92,
          child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 5,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2),
              itemCount: appArray.chartDataList.length,
              itemBuilder: (context, index) => ChartDataLayout(
                  data: appArray.chartDataList[index])))
    ])
        .paddingAll(Insets.i20)
        .boxShapeExtension(color: appColor(context).appTheme.whiteBg);
  }
}
