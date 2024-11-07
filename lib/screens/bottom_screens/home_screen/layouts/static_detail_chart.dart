import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../config.dart';

class StaticDetailChart extends StatelessWidget {
  const StaticDetailChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, value, child) {
      List<String> wmy = <String>['W', 'M', 'Y'];
      Widget bottomTitles(double values, TitleMeta meta) {
        final titles = <String>['M', 'T', 'W', 'T', 'F', 'S', 'S'];
        final months = <String>['Ja', 'Fe', 'Ma', 'Ap', 'Ma', 'Ju', 'Jl'];
        final years = <String>[
          '2016',
          '2017',
          '2018',
          '2019',
          '2020',
          '2021',
          '2022'
        ];

        final Widget text = Text(
            value.selectedIndex == 0
                ? titles[values.toInt()]
                : value.selectedIndex == 1
                    ? months[values.toInt()]
                    : years[values.toInt()],
            style: appCss.dmDenseMedium10
                .textColor(appColor(context).appTheme.lightText));

        return SideTitleWidget(
            axisSide: meta.axisSide,
            space: 10, //margin top
            child: text);
      }

      Widget leftTitles(double value, TitleMeta meta) {
        String text;
        if (value == 0) {
          text = '0k';
        } else if (value == 5) {
          text = '5k';
        } else if (value == 10) {
          text = '10k';
        } else if (value == 15) {
          text = '15k';
        } else if (value == 20) {
          text = '20k';
        } else if (value == 25) {
          text = '25k';
        } else {
          return Container();
        }

        return SideTitleWidget(
            axisSide: meta.axisSide,
            space: 0,
            child: Text(text,
                style: appCss.dmDenseMedium12
                    .textColor(appColor(context).appTheme.lightText)));
      }

      List<_ChartData> weekData = [
        _ChartData('M', 12),
        _ChartData('T', 15),
        _ChartData('W', 30),
        _ChartData('TH', 6.4),
        _ChartData('F', 14),
        _ChartData('S', 7),
        _ChartData('S', 9),
      ];

      List<_ChartData> monthData = [
        _ChartData('Ja', 12),
        _ChartData('Fe', 15),
        _ChartData('Ma', 30),
        _ChartData('Ap', 6.4),
        _ChartData('May', 14),
        _ChartData('Ju', 7),
        _ChartData('Jl', 16),
        _ChartData('Au', 19),
        _ChartData('Se', 10),
        _ChartData('Oc', 15),
        _ChartData('No', 10),
        _ChartData('De', 9),
      ];

      List<_ChartData> yearData = [
        _ChartData('2016', 12),
        _ChartData('2017', 15),
        _ChartData('2018', 30),
        _ChartData('2019', 6.4),
        _ChartData('2020', 14),
        _ChartData('2021', 7),
        _ChartData('2022', 16),
        _ChartData('2023', 19),
        _ChartData('Se', 10),
        _ChartData('2024', 15)
      ];

      return Column(children: [
        Text(language(context, appFonts.staticsDetails),
                style: appCss.dmDenseBold18
                    .textColor(appColor(context).appTheme.darkText))
            .alignment(Alignment.centerLeft),
        const VSpace(Sizes.s15),
        Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Text(language(context, appFonts.weeklyAverage),
                      style: appCss.dmDenseRegular12
                          .textColor(appColor(context).appTheme.darkText))
                  .width(Sizes.s100),
              const HSpace(Sizes.s8),
              Text(language(context, "250k"),
                  style: appCss.dmDenseBold14
                      .textColor(appColor(context).appTheme.primary))
            ]),
            Row(children: [
              ...List.generate(wmy.length, (index) {
                return Text(wmy[index].toString(),
                        style: appCss.dmDenseMedium12.textColor(
                            value.selectedIndex == index
                                ? appColor(context).appTheme.whiteColor
                                : appColor(context).appTheme.lightText))
                    .paddingSymmetric(
                        horizontal: Insets.i7, vertical: Insets.i5)
                    .decorated(
                        color: value.selectedIndex == index
                            ? appColor(context).appTheme.primary
                            : appColor(context).appTheme.fieldCardBg,
                        shape: BoxShape.circle)
                    .paddingOnly(right: Insets.i10)
                    .inkWell(onTap: () => value.onTapWmy(index));
              })
            ])
          ]).paddingAll(Insets.i15),
          SizedBox(
              height: 225,
              width: MediaQuery.of(context).size.width,
              child: Theme(
                data: ThemeData(
                    tooltipTheme: TooltipThemeData(
                        decoration: BoxDecoration(color: Colors.red))),
                child: SfCartesianChart(
                    plotAreaBorderWidth: 0,
                    enableAxisAnimation: true,
                    zoomPanBehavior: ZoomPanBehavior(enablePanning: true),
                    primaryXAxis: CategoryAxis(
                        isVisible: true,
                        interval: 1,
                        majorGridLines: MajorGridLines(width: 0),
                        majorTickLines: MajorTickLines(
                          width: 0,
                        ),
                        visibleMaximum: 5,
                        labelStyle: appCss.dmDenseMedium12
                            .textColor(appColor(context).appTheme.lightText),
                        axisLine: AxisLine(
                            dashArray: <double>[3.0, 2.0],
                            color: appColor(context).appTheme.stroke)),
                    primaryYAxis: NumericAxis(
                      minimum: 0,
                      maximum: 20,
                      interval: 5,
                      labelStyle: appCss.dmDenseMedium12
                          .textColor(appColor(context).appTheme.lightText),
                      labelFormat: '{value}k',

                      majorGridLines: MajorGridLines(
                          dashArray: <double>[3.0, 2.0],
                          color: appColor(context).appTheme.stroke),
                      majorTickLines: MajorTickLines(width: 0),
                      //Hide the axis line of y-axis
                      axisLine: AxisLine(width: 0),
                    ),
                    tooltipBehavior: TooltipBehavior(
                        enable: true,
                        opacity: 0,
                    

                        tooltipPosition: TooltipPosition.auto,
                        elevation: 0,
                        // Templating the tooltip
                        builder: (dynamic data, dynamic point, dynamic series,
                            int pointIndex, int seriesIndex) {
                          log("IN L$pointIndex // $seriesIndex");
                        if(pointIndex == 0 || pointIndex ==5){
                          return RotatedBox(
                            quarterTurns: point.y >15 ? 2:0,
                            child: Container(
                              height: 50,
                              width: 45,

                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(

                                image: DecorationImage(
                                  image: AssetImage(eImageAssets.base),fit: BoxFit.fill
                                )
                              ),
                              child:   RotatedBox(
                                quarterTurns: point.y >15 ? 2:0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(point.y.toString(),
                                        style: appCss.dmDenseSemiBold6
                                            .textColor(appColor(context)
                                            .appTheme
                                            .whiteColor)),
                                    Text("Revenue",
                                        style: appCss.dmDenseSemiBold6
                                            .textColor(appColor(context)
                                            .appTheme
                                            .whiteColor))
                                  ],
                                ).marginOnly(bottom: 10),
                              )
                            ),
                          );
                        }else{
                          return    SizedBox(
                              height: MediaQuery.of(context).size.height / 8,
                              child: RotatedBox(
                                quarterTurns: point.y >8 ? 2:0,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Stack(
                                        alignment: Alignment.topCenter,
                                        children: [
                                          Image.asset(eImageAssets.chartBg,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                                  8,
                                              fit: BoxFit.fill),
                                          RotatedBox(
                                            quarterTurns: point.y >8 ? 2:0,
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(point.y.toString(),
                                                    style: appCss.dmDenseSemiBold10
                                                        .textColor(appColor(context)
                                                        .appTheme
                                                        .whiteColor)),
                                                Text("Revenue",
                                                    style: appCss.dmDenseSemiBold10
                                                        .textColor(appColor(context)
                                                        .appTheme
                                                        .whiteColor))
                                              ],
                                            ).paddingOnly(top: point.y >8 ? 0:15,bottom: point.y >8 ? 15:0),
                                          )
                                        ],
                                      )
                                    ]),
                              ));
                        }
                        }),
                    series: <CartesianSeries<_ChartData, String>>[
                      ColumnSeries<_ChartData, String>(
                          dataSource: value.selectedIndex == 0
                              ? weekData
                              : value.selectedIndex == 1
                                  ? monthData
                                  : yearData,
                          xValueMapper: (_ChartData data, _) => data.x,
                          yValueMapper: (_ChartData data, _) => data.y,
                          borderRadius: SmoothBorderRadius.only(
                              topLeft: SmoothRadius(
                                  cornerRadius: AppRadius.r4,
                                  cornerSmoothing: 1),
                              topRight: SmoothRadius(
                                  cornerRadius: AppRadius.r4,
                                  cornerSmoothing: 1)),
                          borderWidth: 5,
                          width: .3,
                          enableTooltip: true,
                          isTrackVisible: false,

                          selectionBehavior: SelectionBehavior(
                              enable: true,
                              unselectedColor:
                                  appColor(context).appTheme.fieldCardBg,

                              selectedBorderColor: appColor(context)
                                  .appTheme
                                  .primary
                                  .withOpacity(0.10),
                              selectedBorderWidth: 15,
                              selectedColor:
                                  appColor(context).appTheme.primary),
                          color: appColor(context).appTheme.fieldCardBg)
                    ]),
              )).paddingSymmetric(horizontal: Insets.i8)
        ]).boxShapeExtension(color: appColor(context).appTheme.whiteBg)
      ])
          .paddingSymmetric(vertical: Insets.i25, horizontal: Insets.i20)
          .decorated(color: appColor(context).appTheme.fieldCardBg);
    });
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}

class ChartSampleData {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.secondSeriesYValue,
      this.thirdSeriesYValue,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume});

  /// Holds x value of the datapoint
  final dynamic x;

  /// Holds y value of the datapoint
  final num? y;

  /// Holds x value of the datapoint
  final dynamic xValue;

  /// Holds y value of the datapoint
  final num? yValue;

  /// Holds y value of the datapoint(for 2nd series)
  final num? secondSeriesYValue;

  /// Holds y value of the datapoint(for 3nd series)
  final num? thirdSeriesYValue;

  /// Holds point color of the datapoint
  final Color? pointColor;

  /// Holds size of the datapoint
  final num? size;

  /// Holds datalabel/text value mapper of the datapoint
  final String? text;

  /// Holds open value of the datapoint
  final num? open;

  /// Holds close value of the datapoint
  final num? close;

  /// Holds low value of the datapoint
  final num? low;

  /// Holds high value of the datapoint
  final num? high;

  /// Holds open value of the datapoint
  final num? volume;
}
