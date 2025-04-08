import '../config.dart';

class TextFieldCommon extends StatefulWidget {
  final String hintText;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Color? fillColor;
  final bool obscureText, isMaxLine;
  final double? vertical, radius, hPadding;
  final InputBorder? border;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final int? maxLength, minLines, maxLines;
  final ValueChanged<String>? onFieldSubmitted;
  final String? counterText, prefixIcon;
  final TextStyle? hintStyle;
  final bool? isNumber, isEnable;
  final GestureTapCallback? onTap;

  const TextFieldCommon(
      {super.key,
      required this.hintText,
      this.validator,
      this.controller,
      this.suffixIcon,
      this.prefixIcon,
      this.border,
      this.obscureText = false,
      this.fillColor,
      this.vertical,
      this.keyboardType,
      this.focusNode,
      this.onChanged,
      this.onFieldSubmitted,
      this.radius,
      this.isNumber = false,
      this.maxLength,
      this.minLines,
      this.maxLines,
      this.counterText,
      this.hintStyle,
      this.hPadding,
      this.isMaxLine = false,
      this.onTap,
      this.isEnable = true});

  @override
  State<TextFieldCommon> createState() => _TextFieldCommonState();
}

class _TextFieldCommonState extends State<TextFieldCommon> {
  bool isFocus = false;

  @override
  void initState() {
    // TODO: implement initState

    widget.focusNode!.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        enabled: widget.isEnable,
        maxLines: widget.maxLines ?? 1,
        style: appCss.dmDenseMedium14
            .textColor(appColor(context).appTheme.darkText),
        focusNode: widget.focusNode,
        onFieldSubmitted: widget.onFieldSubmitted,
        obscureText: widget.obscureText,
        onTap: widget.onTap,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        controller: widget.controller,
        onChanged: widget.onChanged,
        minLines: widget.minLines,
        cursorColor: appColor(context).appTheme.darkText,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
            counterText: widget.counterText,
            fillColor: widget.fillColor ?? appColor(context).appTheme.whiteBg,
            filled: true,
            isDense: true,
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(widget.radius ?? AppRadius.r8)),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(widget.radius ?? AppRadius.r8)),
                borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(widget.radius ?? AppRadius.r8)),
                borderSide: BorderSide.none),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(widget.radius ?? AppRadius.r8)),
                borderSide: BorderSide.none),
            contentPadding: widget.isMaxLine
                ? const EdgeInsets.only(
                    left: Sizes.s45,
                    right: Insets.i15,
                    top: Insets.i15,
                    bottom: Insets.i15)
                : EdgeInsets.symmetric(
                    horizontal: widget.hPadding ?? Insets.i15,
                    vertical: widget.vertical ?? Insets.i15),
            suffixIcon: widget.suffixIcon,
            prefixIcon: widget.isNumber == true
                ? null
                : widget.prefixIcon == null
                    ? null
                    : SvgPicture.asset(widget.prefixIcon!,
                        fit: BoxFit.scaleDown,
                        colorFilter: ColorFilter.mode(
                            !widget.focusNode!.hasFocus
                                ? widget.controller!.text.isNotEmpty
                                    ? appColor(context).appTheme.darkText
                                    : appColor(context).appTheme.lightText
                                : appColor(context).appTheme.darkText,
                            BlendMode.srcIn)),
            hintStyle: widget.hintStyle ??
                appCss.dmDenseMedium14
                    .textColor(appColor(context).appTheme.lightText),
            hintText: language(context, widget.hintText),
            errorMaxLines: 2));
  }
}
