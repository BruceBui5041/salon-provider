import '../config.dart';

class BookingStatusLayout extends StatelessWidget {
  final String? title;
  final Color? color;
  const BookingStatusLayout({super.key, this.title, this.color});

  Color _getStatusColor(BuildContext context) {
    if (title == null) return appColor(context).appTheme.darkText;

    switch (title?.toLowerCase()) {
      case 'pending':
      case 'published':
        return appColor(context).appTheme.primary;

      case 'success':
      case 'completed':
      case 'paid':
      case 'publishing':
        return appColor(context).appTheme.green;
      case 'failed':
      case 'cancelled':
      case 'declined':
        return appColor(context).appTheme.red;
      case 'draft':
        return appColor(context).appTheme.yellow;
      default:
        return color ?? appColor(context).appTheme.online;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(context);
    return Text(language(context, title!),
            style: appCss.dmDenseMedium11.textColor(statusColor))
        .paddingSymmetric(vertical: Insets.i4, horizontal: Insets.i12)
        .decorated(
            color: statusColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(AppRadius.r50));
  }
}
