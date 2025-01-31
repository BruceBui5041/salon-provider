import 'package:fixit_provider/config.dart';

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}

class ChartDatas {
  ChartDatas(
    this.x,
    this.y,
  );
  final int x;
  final double y;
}
