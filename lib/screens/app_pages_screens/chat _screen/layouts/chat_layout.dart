import '../../../../config.dart';

class ChatLayout extends StatelessWidget {
  final String? title;
  final AlignmentGeometry? alignment;
  final bool? isSentByMe;

  const ChatLayout({Key? key, this.title, this.alignment, this.isSentByMe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String now = TimeOfDay.fromDateTime(DateTime.now()).format(context);
    return Row(
      mainAxisAlignment:
          isSentByMe == true ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: Insets.i15, vertical: Insets.i15),
                decoration: BoxDecoration(
                    color: isSentByMe == true
                        ? appColor(context).appTheme.primary
                        : appColor(context).appTheme.fieldCardBg,
                    borderRadius: rtl(context)
                        ? BorderRadius.only(
                            topRight: const Radius.circular(Insets.i20),
                            topLeft: const Radius.circular(Insets.i20),
                            bottomRight: Radius.circular(
                                isSentByMe == true ? Insets.i20 : 0),
                            bottomLeft: Radius.circular(
                                isSentByMe == true ? 0 : Insets.i20))
                        : BorderRadius.only(
                            topRight: const Radius.circular(Insets.i20),
                            topLeft: const Radius.circular(Insets.i20),
                            bottomRight: Radius.circular(
                                isSentByMe == true ? 0 : Insets.i20),
                            bottomLeft: Radius.circular(
                                isSentByMe == true ? Insets.i20 : 0))),
                child: Column(
                    crossAxisAlignment: isSentByMe == true
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(title ?? "",
                          style: appCss.dmDenseMedium14.textColor(
                              isSentByMe == true
                                  ? appColor(context).appTheme.whiteColor
                                  : appColor(context).appTheme.darkText)),
                      Row(children: [
                        if (isSentByMe == true)
                          SvgPicture.asset(eSvgAssets.doubleTick)
                              .paddingOnly(right: Insets.i5),
                        Text(now,
                            style: appCss.dmDenseRegular12.textColor(
                                isSentByMe == true
                                    ? appColor(context).appTheme.whiteColor
                                    : appColor(context).appTheme.lightText))
                      ])
                    ]))
            .paddingSymmetric(horizontal: Insets.i20, vertical: Insets.i15),
      ],
    );
  }
}
