import '../../../../config.dart';

class ChatHistoryLayout extends StatelessWidget {
  final dynamic data;
  final List? list;
  final int? index;
  final GestureTapCallback? onTap;

  const ChatHistoryLayout({super.key, this.data, this.list, this.index, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Container(
                  height: Sizes.s45,
                  width: Sizes.s45,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(data["image"]),
                          fit: BoxFit.cover))),
              const HSpace(Sizes.s10),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(data["title"],
                    style: appCss.dmDenseMedium14
                        .textColor(appColor(context).appTheme.darkText)),
                const VSpace(Sizes.s2),
                Text(data["message"],
                    style: appCss.dmDenseMedium12
                        .textColor(appColor(context).appTheme.lightText))
              ])
            ]),
            Text(data["time"],
                style: appCss.dmDenseRegular12
                    .textColor(appColor(context).appTheme.lightText))
          ]).inkWell(onTap: onTap),
      if (index != list!.length - 1)
        const DividerCommon().paddingSymmetric(vertical: Insets.i15)
    ]);
  }
}
