import '../../../../config.dart';

class ChartDataLayout extends StatelessWidget {
  final dynamic data;

  const ChartDataLayout({super.key,this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          const SizedBox(
              height: 3,
              width: 9
          ).decorated(color: data["color"],borderRadius: const BorderRadius.all(Radius.circular(10))),
          const HSpace(Sizes.s7),
          Text("${data["title"]} (${data["per"]}%)",style: appCss.dmDenseRegular12.textColor(appColor(context).appTheme.darkText))
        ]
    );
  }
}
