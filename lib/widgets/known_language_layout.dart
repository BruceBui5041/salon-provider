import 'package:fixit_provider/widgets/multi_dropdown_common.dart';
import 'package:flutter/cupertino.dart';
import '../config.dart';

class KnownLanguageLayout extends StatelessWidget {
  const KnownLanguageLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<AddServicemenProvider>(context);
    return Stack(children: [
      MultiSelectDropDownCustom(
              backgroundColor: appColor(context).appTheme.whiteBg,
              onOptionSelected: (options) => value.onLanguageSelect(options),
              options: <ValueItem>[
                ValueItem(
                    label: language(context, appFonts.english), value: '1'),
                ValueItem(
                    label: language(context, appFonts.german), value: '2'),
                ValueItem(
                    label: language(context, appFonts.spanish), value: '3'),
                ValueItem(
                    label: language(context, appFonts.japanese), value: '4'),
              ],
              selectionType: SelectionType.multi,
              hint: language(context, appFonts.selectLanguage),
              optionsBackgroundColor: appColor(context).appTheme.whiteBg,
              selectedOptionBackgroundColor: appColor(context).appTheme.whiteBg,
              hintStyle: appCss.dmDenseMedium14
                  .textColor(appColor(context).appTheme.lightText),
              chipConfig: ChipConfig(
                  wrapType: WrapType.scroll,
                  deleteIcon: Icon(CupertinoIcons.multiply,
                      color: appColor(context).appTheme.darkText,
                      size: Sizes.s15),
                  backgroundColor: appColor(context).appTheme.fieldCardBg,
                  labelColor: appColor(context).appTheme.darkText,
                  deleteIconColor: appColor(context).appTheme.darkText,
                  labelStyle: appCss.dmDenseMedium14
                      .textColor(appColor(context).appTheme.darkText)),
              padding: EdgeInsets.only(
                  left: rtl(context) ? Insets.i10 : Insets.i40,
                  right: rtl(context) ? Insets.i40 : Insets.i10),
              showClearIcon: false,
              borderColor: appColor(context).appTheme.trans,
              borderRadius: AppRadius.r8,
              suffixIcon: SvgPicture.asset(eSvgAssets.dropDown,
                 colorFilter: ColorFilter.mode(value.languageSelect != "[]"
                     ? appColor(context).appTheme.darkText
                     : appColor(context).appTheme.lightText, BlendMode.srcIn) ),
              optionTextStyle: appCss.dmDenseMedium14
                  .textColor(appColor(context).appTheme.darkText),
              selectedOptionIcon: Icon(Icons.check_box_rounded,
                  color: appColor(context).appTheme.primary))
          .paddingSymmetric(horizontal: Insets.i20),
      SvgPicture.asset(
        eSvgAssets.country,
        colorFilter: ColorFilter.mode(
            value.languageSelect != "[]"
                ? appColor(context).appTheme.darkText
                : appColor(context).appTheme.lightText,
            BlendMode.srcIn),
      ).paddingOnly(
          left: rtl(context) ? 0 : Insets.i35,
          right: rtl(context) ? Insets.i35 : 0,
          top: Insets.i16)
    ]);
  }
}
