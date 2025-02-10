import 'package:diacritic/diacritic.dart';
import 'package:figma_squircle_updated/figma_squircle.dart';

import '../config.dart';

extension FixitUserExtensions on Widget {
  Widget boxShapeExtension({Color? color, double? radius}) => Container(
      decoration: ShapeDecoration(
          color: color,
          shape: SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius(
                  cornerRadius: radius ?? 8, cornerSmoothing: 1))),
      child: this);

  Widget boxBorderExtension(context,
          {Color? color, bColor, double? radius, bool? isShadow = false}) =>
      Container(
          decoration: ShapeDecoration(
              color: color ?? appColor(context).appTheme.whiteBg,
              shadows: isShadow == true
                  ? [
                      BoxShadow(
                          color: appColor(context)
                              .appTheme
                              .darkText
                              .withOpacity(0.05),
                          blurRadius: 3,
                          spreadRadius: 1)
                    ]
                  : [],
              shape: SmoothRectangleBorder(
                  side: BorderSide(
                      color: bColor ?? appColor(context).appTheme.fieldCardBg),
                  borderRadius: SmoothBorderRadius(
                      cornerRadius: radius ?? 8, cornerSmoothing: 1))),
          child: this);

  Widget bottomSheetExtension(context) => Container(
      decoration: ShapeDecoration(
          color: appColor(context).appTheme.whiteBg,
          shape: const SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius.only(
                  topLeft: SmoothRadius(cornerRadius: 20, cornerSmoothing: 1),
                  topRight:
                      SmoothRadius(cornerRadius: 20, cornerSmoothing: 1)))),
      child: this);
}

extension FixitStringExtensions on String {
  String toSlug() {
    // Chuyển thành chữ thường
    String slug = toLowerCase();

    // Loại bỏ dấu tiếng Việt
    slug = removeDiacritics(slug);

    // Thay thế các ký tự không phải chữ cái hoặc số bằng dấu '-'
    slug = slug.replaceAll(RegExp(r'[^a-z0-9]+'), '-');

    // Loại bỏ dấu '-' ở đầu và cuối chuỗi
    slug = slug.replaceAll(RegExp(r'^-+|-+$'), '');

    return slug;
  }
}
