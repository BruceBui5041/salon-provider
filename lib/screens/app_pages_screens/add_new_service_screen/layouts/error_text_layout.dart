import 'package:flutter/material.dart';
import 'package:salon_provider/config.dart';

Widget errorTextLayout(
    BuildContext context, String errorText, String valueInput) {
  if (valueInput.isEmpty) {
    return Text(errorText,
        style:
            appCss.dmDenseMedium12.textColor(appColor(context).appTheme.red));
  }
  return Text("",
      style: appCss.dmDenseMedium12.textColor(appColor(context).appTheme.red));
}
