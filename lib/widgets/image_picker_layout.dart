import 'package:salon_provider/screens/app_pages_screens/profile_detail_screen/layouts/selection_option_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../config.dart';

showLayout(context, {Function(int)? onTap}) async {
  showDialog(
    context: context,
    builder: (context1) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppRadius.r12))),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(language(context, appFonts.selectOne),
                  style: appCss.dmDenseBold18
                      .textColor(appColor(context).appTheme.darkText)),
              const Icon(CupertinoIcons.multiply)
                  .inkWell(onTap: () => route.pop(context))
            ]),
            const VSpace(Sizes.s20),
            ...appArray.selectList
                .asMap()
                .entries
                .map((e) => SelectOptionLayout(
                      data: e.value,
                      index: e.key,
                      list: appArray.selectList,
                      onTap: () => onTap!(e.key),
                    ))
                .toList()
          ],
        ),
      );
    },
  );
}
