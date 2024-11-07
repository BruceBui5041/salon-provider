import '../config.dart';

scaffoldMessage(context, title, {isRed = false}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(title,
          style: appCss.dmDenseMedium14
              .textColor(appColor(context).appTheme.whiteColor)),
      backgroundColor: isRed
          ? appColor(context).appTheme.red
          : appColor(context).appTheme.green,
      behavior: SnackBarBehavior.floating));
}
