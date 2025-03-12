// ignore_for_file: unnecessary_null_comparison

import 'package:fixit_provider/model/response/category_response.dart';

import '../../../../config.dart';

class DropDownLayout extends StatelessWidget {
  final String? icon, hintText, val;
  final List? list;
  final ValueChanged? onChanged;
  final bool? isIcon, isField, isBig, isListIcon, isOnlyText;

  const DropDownLayout(
      {super.key,
      this.icon,
      this.hintText,
      this.val,
      this.onChanged,
      this.isField = false,
      this.isIcon = false,
      this.isBig = false,
      this.list,
      this.isListIcon = false,
      this.isOnlyText = false});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
            child: ButtonTheme(
                child: DropdownButtonFormField(
                    hint: Text(language(context, hintText ?? ""),
                        style: appCss.dmDenseMedium14
                            .textColor(appColor(context).appTheme.lightText)),
                    decoration: InputDecoration(
                        prefixIcon: isIcon == true
                            ? SvgPicture.asset(icon!,
                                fit: BoxFit.scaleDown,
                                colorFilter: ColorFilter.mode(
                                    val == null
                                        ? appColor(context).appTheme.lightText
                                        : appColor(context).appTheme.darkText,
                                    BlendMode.srcIn))
                            : null,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                        disabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(AppRadius.r8)),
                            borderSide: BorderSide.none),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(AppRadius.r8)),
                            borderSide: BorderSide.none),
                        enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(AppRadius.r8)),
                            borderSide: BorderSide.none),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(AppRadius.r8)),
                            borderSide: BorderSide.none)),
                    padding: EdgeInsets.zero,
                    value: val,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(AppRadius.r8)),
                    style: appCss.dmDenseMedium14.textColor(val == null ? appColor(context).appTheme.lightText : appColor(context).appTheme.darkText),
                    icon: SvgPicture.asset(eSvgAssets.dropDown, colorFilter: ColorFilter.mode(val == null ? appColor(context).appTheme.lightText : appColor(context).appTheme.darkText, BlendMode.srcIn)),
                    isDense: true,
                    isExpanded: true,
                    items: list!.asMap().entries.map((e) {
                      var val = e.value as CategoryItem;
                      return DropdownMenuItem<CategoryItem>(
                          value: val,
                          child: Row(
                            children: [
                              if (isListIcon == true)
                                SizedBox(
                                        height: Sizes.s13,
                                        width: Sizes.s13,
                                        child: Image.network(
                                          val.image ?? '',
                                          fit: BoxFit.scaleDown,
                                        ))
                                    .paddingAll(Insets.i4)
                                    .decorated(
                                        color: appColor(context)
                                            .appTheme
                                            .fieldCardBg,
                                        shape: BoxShape.circle),
                              if (isListIcon == true) const HSpace(Sizes.s12),
                              Text(language(context, val.name ?? ''),
                                  style: appCss.dmDenseMedium14.textColor(val ==
                                          null
                                      ? appColor(context).appTheme.lightText
                                      : appColor(context).appTheme.darkText)),
                            ],
                          ));
                    }).toList(),
                    onChanged: onChanged)))
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
            right: rtl(context) ? 10 : Insets.i10)
        .decorated(color: isField == true ? appColor(context).appTheme.fieldCardBg : appColor(context).appTheme.whiteBg, borderRadius: BorderRadius.circular(AppRadius.r8));
  }
}
