import '../../../config.dart';

class EarningScreen extends StatelessWidget {
  const EarningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('Cleaning', 35, Color(0xFF5465FF)),
      ChartData('Ac repair', 25, Color(0xFF7482FD)),
      ChartData('Painting', 20, Color(0xFF949FFC)),
      ChartData('Carpenter', 18, Color(0xFFB5BCFA)),
      ChartData('Salon', 12, Color(0xFFD5D9F9))
    ];

    return Scaffold(
        appBar: AppBarCommon(title: appFonts.earnings),
        body: SingleChildScrollView(
            child: Column(children: [
          Column(children: [
            Container(
                height: Sizes.s63,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(eImageAssets.balanceContainer),
                        fit: BoxFit.fill)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          language(context,
                              "${language(context, appFonts.totalEarning)} :"),
                          style: appCss.dmDenseMedium12
                              .textColor(appColor(context).appTheme.whiteBg)),
                      Text("\$3,262.03",
                          style: appCss.dmDenseBold18
                              .textColor(appColor(context).appTheme.whiteColor))
                    ]).paddingSymmetric(horizontal: Insets.i20)),
            const VSpace(Sizes.s30),
            Column(children: [
              Stack(alignment: Alignment.center, children: [
                // SfCircularChart(series: <CircularSeries>[
                //   DoughnutSeries<ChartData, String>(
                //       dataSource: chartData,
                //       xValueMapper: (ChartData data, _) => data.x,
                //       yValueMapper: (ChartData data, _) => data.y,
                //       cornerStyle: CornerStyle.bothCurve,
                //       pointColorMapper: (ChartData data, _) => data.color,
                //       explodeAll: true,
                //       innerRadius: '85%',
                //       explode: true)
                // ]),
                SizedBox(
                    width: Sizes.s120,
                    child: Text(language(context, appFonts.topCategorys),
                        textAlign: TextAlign.center,
                        style: appCss.dmDenseMedium16
                            .textColor(appColor(context).appTheme.darkText)))
              ]),
              const EarningPercentageLayout()
            ]).paddingAll(Insets.i15).boxShapeExtension(
                color: appColor(context).appTheme.fieldCardBg)
          ]).paddingSymmetric(horizontal: Insets.i20),
          const VSpace(Sizes.s25),
          const HistoryBody()
        ])));
  }
}
