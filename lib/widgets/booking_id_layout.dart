import '../config.dart';

class BookingIdLayout extends StatelessWidget {
  final String? id;
  final String? transactionStatus;
  const BookingIdLayout({super.key, this.id, this.transactionStatus});

  Color _getStatusColor(BuildContext context) {
    if (transactionStatus == null) return appColor(context).appTheme.primary;

    switch (transactionStatus?.toLowerCase()) {
      case 'success':
      case 'completed':
      case 'paid':
        return appColor(context).appTheme.green;
      case 'failed':
      case 'cancelled':
      case 'declined':
        return appColor(context).appTheme.red;
      default:
        return appColor(context).appTheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getStatusColor(context);
    return Text("#$id", style: appCss.dmDenseMedium12.textColor(color))
        .paddingSymmetric(vertical: Insets.i6, horizontal: Insets.i10)
        .decorated(
            color: color.withValues(alpha: 0.15),
            borderRadius:
                const BorderRadius.all(Radius.circular(AppRadius.r16)));
  }
}
