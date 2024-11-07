import '../../../../config.dart';

class AllTimeSlotLayout extends StatelessWidget {
  final dynamic data;
  final ValueChanged<bool>? onToggle;
  final int? index;
  final List? list;
  final GestureTapCallback? onTap,onTapSecond;
  const AllTimeSlotLayout({super.key,this.data,this.onToggle, this.index, this.list,this.onTap, this.onTapSecond});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(data["days"].toUpperCase(),
                  style: appCss.dmDenseMedium12
                      .textColor(appColor(context).appTheme.primary))
                  .paddingAll(Insets.i10)
                  .decorated(
                  shape: BoxShape.circle,
                  color:
                  appColor(context).appTheme.primary.withOpacity(0.1)),
               Row(
                  children: [
                    StartSlotLayout(title: data["start_at"],isSwitch: data["status"]).inkWell(onTap: onTap),
                    const HSpace(Sizes.s12),
                    StartSlotLayout(title: data["end_at"],isSwitch: data["status"]).inkWell(onTap: onTapSecond)
                  ]
              ),
              FlutterSwitchCommon(value: data["status"],onToggle: onToggle)
            ]),
        if(index != list!.length -1)
        const DottedLines().paddingSymmetric(vertical: Insets.i12)
      ]
    ).paddingSymmetric(horizontal: Insets.i15);
  }
}
