import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../config.dart';

class AddServiceImageLayout extends StatelessWidget {
  final String? image;
  final GestureTapCallback? onDelete;
  const AddServiceImageLayout({super.key, this.image, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
            height: Sizes.s70,
            width: Sizes.s70,
            decoration: ShapeDecoration(
                image: DecorationImage(
                    image: FileImage(
                        File(image!)),
                    fit: BoxFit.cover),
                shape: RoundedRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                        cornerRadius: AppRadius.r8,
                        cornerSmoothing: 1)))),
        Container(
            padding: const EdgeInsets.all(Insets.i4),
            decoration: ShapeDecoration(
                color: appColor(context).appTheme.darkText.withOpacity(0.5),
                shape: const SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius.only(
                        bottomLeft: SmoothRadius(
                            cornerRadius: AppRadius.r6, cornerSmoothing: 1),
                        topRight: SmoothRadius(
                            cornerRadius: AppRadius.r6,
                            cornerSmoothing: 1)))),
            child: Icon(CupertinoIcons.multiply,
                color: appColor(context).appTheme.whiteColor,
                size: Sizes.s14))
            .inkWell(onTap: onDelete)
      ],
    ).paddingOnly(right: rtl(context) ? 0 : Insets.i10, left: rtl(context) ? Insets.i10 : 0);
  }
}
