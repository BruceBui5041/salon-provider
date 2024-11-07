import '../../../../config.dart';
import '../../../../widgets/progress_bar_common.dart';

class ProgressBarLayout extends StatelessWidget {
  final dynamic data;
  final int? index;
  final List? list;

  const ProgressBarLayout({super.key,this.data,this.list,this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
            Text(language(context, data["star"]),style: appCss.dmDenseRegular13.textColor(appColor(context).appTheme.darkText)),
          Expanded(child:  ProgressBar(max: 100, current: data["percentage"]).paddingSymmetric(horizontal: Insets.i15)),
          Text("${data["percentage"]}%",style: appCss.dmDenseMedium12.textColor(appColor(context).appTheme.lightText))
        ]
    ).paddingOnly(bottom: index != list!.length -1 ? Insets.i20 : 0);
  }
}
