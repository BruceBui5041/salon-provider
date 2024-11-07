import '../config.dart';

extension FixitUserExtensions on Widget {
  Widget boxShapeExtension({Color? color, double? radius}) => Container(
      decoration: ShapeDecoration(
          color: color,
          shape: SmoothRectangleBorder(
              borderRadius:
                  SmoothBorderRadius(cornerRadius: radius ?? 8, cornerSmoothing: 1))),
      child: this);

  Widget boxBorderExtension(context,{Color? color,bColor, double? radius, bool? isShadow = false}) => Container(
      decoration: ShapeDecoration(

          color: color ?? appColor(context).appTheme.whiteBg,
          shadows: isShadow == true ? [
            BoxShadow(
              color: appColor(context).appTheme.darkText.withOpacity(0.05),
              blurRadius: 3 ,
              spreadRadius: 1
            )
          ] : [],
          shape: SmoothRectangleBorder(
            side: BorderSide(color: bColor ?? appColor(context).appTheme.fieldCardBg),
              borderRadius:
              SmoothBorderRadius(cornerRadius: radius ?? 8, cornerSmoothing: 1))),
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
