import '../../../../config.dart';

class WalletRowLayout extends StatelessWidget {
  final String? title, id;
  const WalletRowLayout({super.key, this.title, this.id});

  Color _getStatusColor(BuildContext context) {
    if (id == null) return appColor(context).appTheme.darkText;

    switch (id?.toLowerCase()) {
      case 'success':
      case 'completed':
      case 'paid':
        return appColor(context).appTheme.green;
      case 'failed':
      case 'cancelled':
      case 'declined':
        return appColor(context).appTheme.red;
      default:
        return language(context, title!) == language(context, appFonts.status)
            ? appColor(context).appTheme.primary
            : appColor(context).appTheme.darkText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(language(context, title!),
          style: appCss.dmDenseRegular12
              .textColor(appColor(context).appTheme.lightText)),
      Text(
        id!,
        style: appCss.dmDenseMedium14.textColor(_getStatusColor(context)),
      )
    ]).paddingOnly(bottom: Insets.i22);
  }
}
