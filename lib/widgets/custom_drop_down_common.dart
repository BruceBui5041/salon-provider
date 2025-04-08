import '../../../../config.dart';

class CustomDropDownLayout<T> extends StatelessWidget {
  final String? icon, hintText;
  final T? value;
  final List<T>? items;
  final ValueChanged<T?>? onChanged;
  final bool? isIcon, isField, isBig, isListIcon, isOnlyText;
  final Widget Function(BuildContext context, T item) itemBuilder;

  const CustomDropDownLayout({
    super.key,
    this.icon,
    this.hintText,
    this.value,
    this.items,
    this.onChanged,
    this.isField = false,
    this.isIcon = false,
    this.isBig = false,
    this.isListIcon = false,
    this.isOnlyText = false,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          child: DropdownButtonFormField<T>(
            hint: Text(
              language(context, hintText ?? ""),
              style: appCss.dmDenseMedium14
                  .textColor(appColor(context).appTheme.lightText),
            ),
            decoration: InputDecoration(
              prefixIcon: isIcon == true
                  ? SvgPicture.asset(
                      icon!,
                      fit: BoxFit.scaleDown,
                      colorFilter: ColorFilter.mode(
                        value == null
                            ? appColor(context).appTheme.lightText
                            : appColor(context).appTheme.darkText,
                        BlendMode.srcIn,
                      ),
                    )
                  : null,
              // contentPadding: EdgeInsets.zero,
              isDense: true,
              disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(AppRadius.r8)),
                borderSide: BorderSide.none,
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(AppRadius.r8)),
                borderSide: BorderSide.none,
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(AppRadius.r8)),
                borderSide: BorderSide.none,
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(AppRadius.r8)),
                borderSide: BorderSide.none,
              ),
            ),
            padding: EdgeInsets.zero,
            value: value,
            borderRadius: const BorderRadius.all(Radius.circular(AppRadius.r8)),
            style: appCss.dmDenseMedium14.textColor(
              value == null
                  ? appColor(context).appTheme.lightText
                  : appColor(context).appTheme.darkText,
            ),
            icon: SvgPicture.asset(
              eSvgAssets.dropDown,
              colorFilter: ColorFilter.mode(
                value == null
                    ? appColor(context).appTheme.lightText
                    : appColor(context).appTheme.darkText,
                BlendMode.srcIn,
              ),
            ),
            isDense: true,
            isExpanded: true,
            items: items?.map((item) {
              return DropdownMenuItem<T>(
                value: item,
                child: itemBuilder(context, item),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      )
          .padding(
            vertical: isBig == true
                ? Insets.i14
                : isOnlyText == true
                    ? Insets.i5
                    : 0,
            left: isIcon == false
                ? rtl(context)
                    ? Insets.i15
                    : Insets.i10
                : rtl(context)
                    ? Insets.i15
                    : Insets.i2,
            right: rtl(context) ? 10 : Insets.i10,
          )
          .decorated(
            color: isField == true
                ? appColor(context).appTheme.fieldCardBg
                : appColor(context).appTheme.whiteBg,
            borderRadius: BorderRadius.circular(AppRadius.r8),
          ),
    );
  }
}
