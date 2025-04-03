import '../../../../config.dart';

class StatusRow extends StatelessWidget {
  final String? title, title2, statusText;

  final TextStyle? style;
  const StatusRow(
      {super.key, this.title, this.style, this.title2, this.statusText});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      textCommon.dmSensMediumLight12(context, text: title),
      title == appFonts.status
          ? BookingStatusLayout(
              title: statusText, color: colorCondition(statusText, context))
          : Text(title2!, style: style)
    ]).paddingOnly(bottom: Insets.i12);
  }
}
