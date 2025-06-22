import '../../../../config.dart';

class StatusRow extends StatelessWidget {
  final String? title, title2, statusText;
  final TextStyle? style;
  final int? maxLines;

  const StatusRow({
    super.key,
    this.title,
    this.style,
    this.title2,
    this.statusText,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      textCommon.dmSensMediumLight12(context, text: title),
      title == appFonts.status
          ? BookingStatusLayout(
              title: statusText, color: colorCondition(statusText, context))
          : Text(
              title2!,
              style: style,
              maxLines: maxLines,
              overflow: maxLines != null ? TextOverflow.ellipsis : null,
            )
    ]).paddingOnly(bottom: Insets.i12);
  }
}
