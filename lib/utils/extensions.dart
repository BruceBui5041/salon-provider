import 'package:diacritic/diacritic.dart';
import 'package:figma_squircle_updated/figma_squircle.dart';
import 'package:intl/intl.dart';

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
  String capitalizeFirst() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

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

  String toCurrencyVnd() {
    // Loại bỏ các ký tự không phải số hoặc dấu phân cách
    String cleanedValue = replaceAll(RegExp(r'[^0-9,.-]'), '');

    // Chuyển dấu phẩy thành dấu chấm (nếu có)
    cleanedValue = cleanedValue.replaceAll(',', '.');

    // Chuyển chuỗi thành số double
    double? number = double.tryParse(cleanedValue);

    // Nếu không thể parse, trả về 0₫
    if (number == null) return "0 vnđ";

    // Định dạng lại thành tiền tệ Việt Nam
    final formatCurrency =
        NumberFormat.currency(locale: 'vi_VN', symbol: 'vnđ');

    return formatCurrency.format(number);
  }
}

extension number on int {
  String convertIntToDecimalLocalVi(int value) {
    final formatCurrency = NumberFormat.decimalPattern('vi_VN');
    return formatCurrency.format(value);
  }
}
