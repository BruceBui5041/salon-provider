import '../../../../config.dart';

class CommissionRowCommon extends StatelessWidget {
  final dynamic data;
  const CommissionRowCommon({super.key,this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(data["title"],
              style: appCss.dmDenseRegular14
                  .textColor(appColor(context).appTheme.darkText)),
          Text("${data["commission"]}%",
              style: appCss.dmDenseMedium14
                  .textColor(appColor(context).appTheme.darkText))
        ]
    ).paddingOnly(bottom: Insets.i20);
  }
}
