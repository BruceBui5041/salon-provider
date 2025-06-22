import '../../../../config.dart';

class StatusRow extends StatelessWidget {
  final String? title, title2, statusText;
  final TextStyle? style;
  final int? maxLines;
  final String? infoTooltip;

  const StatusRow({
    super.key,
    this.title,
    this.style,
    this.title2,
    this.statusText,
    this.maxLines,
    this.infoTooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(
        children: [
          textCommon.dmSensMediumLight12(context, text: title),
          if (infoTooltip != null) ...[
            const HSpace(Sizes.s5),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      title!,
                      style: appCss.dmDenseMedium16
                          .textColor(appColor(context).appTheme.darkText),
                    ),
                    content: Text(
                      infoTooltip!,
                      style: appCss.dmDenseRegular14
                          .textColor(appColor(context).appTheme.darkText),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          'OK',
                          style: appCss.dmDenseMedium14
                              .textColor(appColor(context).appTheme.primary),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                child: Icon(
                  Icons.info_outline,
                  size: Sizes.s16,
                  color: appColor(context).appTheme.primary,
                ),
              ),
            ),
          ],
        ],
      ),
      title == appFonts.status
          ? BookingStatusLayout(
              title: statusText, color: colorCondition(statusText, context))
          : Container(
              width: 200,
              alignment: Alignment.centerRight,
              child: Text(
                title2!,
                style: style,
                maxLines: maxLines,
                overflow: TextOverflow.ellipsis,
              ),
            )
    ]).paddingOnly(bottom: Insets.i12);
  }
}
