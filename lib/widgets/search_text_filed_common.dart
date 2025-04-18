import '../config.dart';

class SearchTextFieldCommon extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  const SearchTextFieldCommon({super.key,this.controller,this.suffixIcon,this.onChanged, this.focusNode});

  @override
  Widget build(BuildContext context) {
    return TextFieldCommon(
      focusNode: focusNode,
        hintStyle: appCss.dmDenseRegular12.textColor(appColor(context).appTheme.lightText),
        radius: AppRadius.r23,
        hintText: appFonts.searchHere,
        controller: controller,
        fillColor: appColor(context).appTheme.fieldCardBg,
        suffixIcon: suffixIcon,
        onChanged:onChanged,
        prefixIcon: eSvgAssets.search);
  }
}
