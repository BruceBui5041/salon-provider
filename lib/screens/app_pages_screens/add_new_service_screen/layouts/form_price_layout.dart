import 'package:figma_squircle_updated/figma_squircle.dart';

import '../../../../config.dart';

/// A layout widget that handles the price and tax sections of the add new service form.
/// This includes price selection, amount input, discount input, tax selection, and featured points.
class FormPriceLayout extends StatelessWidget {
  const FormPriceLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewServiceProvider>(
      builder: (context, value, child) {
        return Column(
          children: [
            // _buildPriceSection(context, value),
            _buildAmountSection(context, value),
            // _buildTaxSection(context, value),
            _buildFeaturedPointsSection(context, value),
            // _dropdownDraftService(context, value),
            // _buildStatusSection(context, value),
          ],
        );
      },
    );
  }

  /// Builds the price selection section with radio buttons
  Widget _buildPriceSection(BuildContext context, AddNewServiceProvider value) {
    return Column(
      children: [
        ContainerWithTextLayout(
          title: language(context, appFonts.price),
        ).paddingOnly(top: Insets.i24, bottom: Insets.i12),
        Container(
          decoration: ShapeDecoration(
            color: appColor(context).appTheme.whiteBg,
            shape: RoundedRectangleBorder(
              borderRadius: SmoothBorderRadius(
                cornerRadius: AppRadius.r8,
                cornerSmoothing: 0,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: appArray.priceList
                .asMap()
                .entries
                .map(
                  (e) => PriceLayout(
                    title: e.value["title"],
                    index: e.key,
                    selectIndex: value.selectIndex,
                    onTap: () => value.onChangePrice(e.key),
                  ),
                )
                .toList(),
          ).paddingAll(Insets.i15),
        ).paddingSymmetric(horizontal: Insets.i20),
      ],
    );
  }

  /// Builds the amount input section based on selected price type
  Widget _buildAmountSection(
      BuildContext context, AddNewServiceProvider value) {
    // if (value.selectIndex == 0) {
    //   return _buildSingleAmountInput(context, value);
    // } else if (value.selectIndex == 1) {
    //   return _buildAmountWithDiscountInput(context, value);
    // }
    // return const SizedBox.shrink();
    return Row(children: [
      // Expanded(child: _buildSingleAmountInput(context, value)),
      Expanded(child: _buildAmountWithDiscountInput(context, value)),
    ]);
  }

  /// Builds a single amount input field
  Widget _buildSingleAmountInput(
      BuildContext context, AddNewServiceProvider value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          language(context, appFonts.amount),
          style: appCss.dmDenseSemiBold14.textColor(
            appColor(context).appTheme.darkText,
          ),
        ).paddingOnly(bottom: Insets.i8),
        TextFieldCommon(
          keyboardType: TextInputType.number,
          focusNode: value.amountFocus,
          controller: value.amount,
          hintText: appFonts.enterAmt,
          prefixIcon: eSvgAssets.dollar,
        ),
      ],
    ).padding(horizontal: Insets.i20, top: Insets.i24);
  }

  /// Builds amount and discount input fields side by side
  Widget _buildAmountWithDiscountInput(
      BuildContext context, AddNewServiceProvider value) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                language(context, appFonts.amount),
                style: appCss.dmDenseSemiBold14.textColor(
                  appColor(context).appTheme.darkText,
                ),
              ).paddingOnly(bottom: Insets.i8),
              TextFieldCommon(
                keyboardType: TextInputType.number,
                focusNode: value.amountFocus,
                controller: value.amount,
                hintText: appFonts.enterAmt,
                prefixIcon: eSvgAssets.dollar,
              ),
            ],
          ),
        ),
        const HSpace(Sizes.s15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                language(context, appFonts.discount),
                style: appCss.dmDenseSemiBold14.textColor(
                  appColor(context).appTheme.darkText,
                ),
              ).paddingOnly(bottom: Insets.i8),
              TextFieldCommon(
                keyboardType: TextInputType.number,
                focusNode: value.discountFocus,
                controller: value.discount,
                hintText: appFonts.addDic,
                prefixIcon: eSvgAssets.discount,
              ),
            ],
          ),
        ),
      ],
    ).padding(horizontal: Insets.i20, top: Insets.i24);
  }

  /// Builds the tax selection section
  Widget _buildTaxSection(BuildContext context, AddNewServiceProvider value) {
    return Column(
      children: [
        ContainerWithTextLayout(
          title: language(context, appFonts.tax),
        ).paddingOnly(top: Insets.i24, bottom: Insets.i12),
        DropDownLayout(
          val: value.taxIndex,
          icon: eSvgAssets.receiptDiscount,
          hintText: appFonts.selectTax,
          isIcon: true,
          onChanged: (val) => value.onChangeTax(val),
        ).paddingSymmetric(horizontal: Insets.i20),
      ],
    );
  }

  /// Builds the featured points input section
  Widget _buildFeaturedPointsSection(
      BuildContext context, AddNewServiceProvider value) {
    return Column(
      children: [
        ContainerWithTextLayout(
          title: language(context, appFonts.featuredPoints),
        ).paddingOnly(top: Insets.i24, bottom: Insets.i12),
        Stack(
          children: [
            TextFieldCommon(
              focusNode: value.featuredPointsFocus,
              controller: value.featuredPoints,
              hintText: appFonts.writeANote,
              maxLines: 3,
              minLines: 3,
              isNumber: true,
              isMaxLine: true,
            ).paddingSymmetric(horizontal: Insets.i20),
            _buildDetailsIcon(context, value),
          ],
        ),
      ],
    );
  }

  /// Builds the details icon for the featured points input
  Widget _buildDetailsIcon(BuildContext context, AddNewServiceProvider value) {
    return SvgPicture.asset(
      eSvgAssets.details,
      fit: BoxFit.scaleDown,
      colorFilter: ColorFilter.mode(
        !value.featuredPointsFocus.hasFocus
            ? value.featuredPoints.text.isNotEmpty
                ? appColor(context).appTheme.darkText
                : appColor(context).appTheme.lightText
            : appColor(context).appTheme.darkText,
        BlendMode.srcIn,
      ),
    ).paddingOnly(
      left: rtl(context) ? 0 : Insets.i35,
      right: rtl(context) ? Insets.i35 : 0,
      top: Insets.i13,
    );
  }

  /// Builds the status toggle section
  Widget _buildStatusSection(
      BuildContext context, AddNewServiceProvider value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                language(context, appFonts.status),
                style: appCss.dmDenseSemiBold14.textColor(
                  appColor(context).appTheme.darkText,
                ),
              ),
              Text(
                language(context, appFonts.thisServiceCanBe),
                style: appCss.dmDenseRegular12.textColor(
                  appColor(context).appTheme.lightText,
                ),
              ),
            ],
          ),
        ),
        const HSpace(Sizes.s25),
        Expanded(
          flex: 2,
          child: FlutterSwitchCommon(
            value: value.isSwitch,
            onToggle: (val) => value.onTapSwitch(val),
          ),
        ),
      ],
    )
        .paddingAll(Insets.i15)
        .boxShapeExtension(color: appColor(context).appTheme.whiteBg)
        .paddingSymmetric(horizontal: Insets.i20);
  }
}
