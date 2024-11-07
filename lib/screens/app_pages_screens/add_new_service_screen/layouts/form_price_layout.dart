import 'dart:developer';

import '../../../../config.dart';

class FormPriceLayout extends StatelessWidget {
  const FormPriceLayout({super.key});

  @override
  Widget build(BuildContext context) {


    return Consumer<AddNewServiceProvider>(builder: (context1, value, child) {
      log(" value.featuredPointsFocus.hasFocus ;${ value.descriptionFocus.hasFocus}");
        return Column(children: [
          ContainerWithTextLayout(title: language(context, appFonts.price))
              .paddingOnly(top: Insets.i24, bottom: Insets.i12),
          Container(
                  decoration: ShapeDecoration(
                      color: appColor(context).appTheme.whiteBg,
                      shape: RoundedRectangleBorder(
                          borderRadius: SmoothBorderRadius(
                              cornerRadius: AppRadius.r8, cornerSmoothing: 0))),
                  child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: appArray.priceList
                              .asMap()
                              .entries
                              .map((e) => PriceLayout(
                                  title: e.value["title"],
                                  index: e.key,
                                  selectIndex: value.selectIndex,
                                  onTap: () => value.onChangePrice(e.key)))
                              .toList())
                      .paddingAll(Insets.i15))
              .paddingSymmetric(horizontal: Insets.i20),
          if(value.selectIndex == 0)
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(language(context, appFonts.amount),
                  style: appCss.dmDenseSemiBold14
                      .textColor(appColor(context).appTheme.darkText))
                  .paddingOnly(bottom: Insets.i8),
              TextFieldCommon(
                keyboardType: TextInputType.number,
                  focusNode: value.amountFocus,
                  controller: value.amount,
                  hintText: appFonts.enterAmt,
                  prefixIcon: eSvgAssets.dollar)
            ]).padding(horizontal: Insets.i20, top: Insets.i24),
          if(value.selectIndex == 1)
          Row(children: [
            Expanded(
                child:
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(language(context, appFonts.amount),
                      style: appCss.dmDenseSemiBold14
                          .textColor(appColor(context).appTheme.darkText))
                  .paddingOnly(bottom: Insets.i8),
              TextFieldCommon(
                  keyboardType: TextInputType.number,
                  focusNode: value.amountFocus,
                  controller: value.amount,
                  hintText: appFonts.enterAmt,
                  prefixIcon: eSvgAssets.dollar)
            ])),
            const HSpace(Sizes.s15),

            Expanded(
                child:
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(language(context, appFonts.discount),
                      style: appCss.dmDenseSemiBold14
                          .textColor(appColor(context).appTheme.darkText))
                  .paddingOnly(bottom: Insets.i8),
              TextFieldCommon(
                  keyboardType: TextInputType.number,
                  focusNode: value.discountFocus,
                  controller: value.discount,
                  hintText: appFonts.addDic,
                  prefixIcon: eSvgAssets.discount)
            ]))
          ]).padding(horizontal: Insets.i20, top: Insets.i24),
          ContainerWithTextLayout(title: language(context, appFonts.tax))
              .paddingOnly(top: Insets.i24, bottom: Insets.i12),
          DropDownLayout(
                  val: value.taxIndex,
                  icon: eSvgAssets.receiptDiscount,
                  hintText: appFonts.selectTax,
                  isIcon: true,
                  categoryList: appArray.taxList,
                  onChanged: (val) => value.onChangeTax(val))
              .paddingSymmetric(horizontal: Insets.i20),
          ContainerWithTextLayout(title: language(context, appFonts.featuredPoints))
              .paddingOnly(top: Insets.i24, bottom: Insets.i12),
          Stack(children: [
            TextFieldCommon(
                    focusNode: value.featuredPointsFocus,
                    controller: value.featuredPoints,
                    hintText: appFonts.writeANote,
                    maxLines: 3,


                    minLines: 3,
                    isNumber: true,
                    isMaxLine: true)
                .paddingSymmetric(horizontal: Insets.i20),
            SvgPicture.asset(eSvgAssets.details,
                    fit: BoxFit.scaleDown,
                    colorFilter: ColorFilter.mode(
                        !value.featuredPointsFocus.hasFocus
                            ? value.featuredPoints.text.isNotEmpty
                                ? appColor(context).appTheme.darkText
                                : appColor(context).appTheme.lightText
                            : appColor(context).appTheme.darkText,
                        BlendMode.srcIn))
                .paddingOnly(
                    left: rtl(context) ? 0 : Insets.i35,
                    right: rtl(context) ? Insets.i35 : 0,
                    top: Insets.i13)
          ]),
          const VSpace(Sizes.s20),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
                flex: 8,
                child:
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(language(context, appFonts.status),
                      style: appCss.dmDenseSemiBold14
                          .textColor(appColor(context).appTheme.darkText)),
                  Text(language(context, appFonts.thisServiceCanBe),
                      style: appCss.dmDenseRegular12
                          .textColor(appColor(context).appTheme.lightText))
                ])),
            const HSpace(Sizes.s25),
            Expanded(
                flex: 2,
                child: FlutterSwitchCommon(
                    value: value.isSwitch,
                    onToggle: (val) => value.onTapSwitch(val)))
          ])
              .paddingAll(Insets.i15)
              .boxShapeExtension(color: appColor(context).appTheme.whiteBg)
              .paddingSymmetric(horizontal: Insets.i20)
        ]);
      }
    );
  }
}
