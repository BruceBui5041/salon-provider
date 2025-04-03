import 'dart:developer';

import 'package:figma_squircle_updated/figma_squircle.dart';
import 'package:salon_provider/model/response/category_response.dart';
import 'package:salon_provider/widgets/cache_image.dart';
import 'package:salon_provider/widgets/custom_drop_down_common.dart';

import '../../../../config.dart';

/// A layout widget that handles the category and commission sections
/// of the add new service form.
class FormCategoryLayout extends StatelessWidget {
  const FormCategoryLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<AddNewServiceProvider>(context);
    log("value.categoryValue :${value.categoryValue}");

    return Column(
      children: [
        _buildCategorySection(context, value),
        _buildSubCategorySection(context, value),
        _buildCommissionSection(context),
      ],
    );
  }

  /// Builds the category selection section
  Widget _buildCategorySection(
      BuildContext context, AddNewServiceProvider value) {
    return Column(
      children: [
        ContainerWithTextLayout(
          title: language(context, appFonts.category),
        ).paddingOnly(top: Insets.i24, bottom: Insets.i12),
        // DropDownLayout(
        //   icon: eSvgAssets.categorySmall,
        //   val: value.categoryValue?.name ?? '',
        //   hintText: appFonts.select,
        //   isIcon: true,
        //   onChanged: (val) => value.onChangeCategory(val),
        // ).paddingSymmetric(horizontal: Insets.i20),
        CustomDropDownLayout<CategoryItem>(
          icon: eSvgAssets.categorySmall,
          value: value.categoryValue,
          items: value.categoryResponse?.data,
          onChanged: (CategoryItem? val) => value.onChangeCategory(val!),
          itemBuilder: (BuildContext context, item) {
            return Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.r100),
                  child: Container(
                    height: Sizes.s30,
                    width: Sizes.s30,
                    decoration: BoxDecoration(
                      color: appColor(context).appTheme.fieldCardBg,
                      shape: BoxShape.circle,
                    ),
                    child: CacheImageWidget(
                      url: item.image ?? '',
                    ),
                  ),
                ),
                const HSpace(Sizes.s12),
                Text(language(context, item.name ?? ''),
                    style: appCss.dmDenseMedium14
                        .textColor(appColor(context).appTheme.darkText)),
              ],
            );
          },
        ).paddingSymmetric(horizontal: Insets.i20),
      ],
    );
  }

  /// Builds the subcategory selection section
  Widget _buildSubCategorySection(
      BuildContext context, AddNewServiceProvider value) {
    return Column(
      children: [
        ContainerWithTextLayout(
          title: language(context, appFonts.subCategory),
        ).paddingOnly(top: Insets.i24, bottom: Insets.i12),
        // DropDownLayout(
        //   icon: eSvgAssets.subCategory,
        //   val: value.subCategoryValue?.name,
        //   isIcon: true,
        //   hintText: appFonts.select,
        //   onChanged: (val) => value.onChangeSubCategory(val),
        // ).paddingSymmetric(horizontal: Insets.i20),
        CustomDropDownLayout<CategoryItem>(
          icon: eSvgAssets.subCategory,
          value: value.subCategoryValue,
          items: value.subCategoryResponse?.data,
          onChanged: (CategoryItem? val) => value.onChangeSubCategory(val!),
          itemBuilder: (BuildContext context, CategoryItem item) {
            return Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.r100),
                  child: Container(
                    height: Sizes.s30,
                    width: Sizes.s30,
                    decoration: BoxDecoration(
                      color: appColor(context).appTheme.fieldCardBg,
                      shape: BoxShape.circle,
                    ),
                    child: CacheImageWidget(
                      url: item.image ?? '',
                    ),
                  ),
                ),
                const HSpace(Sizes.s12),
                Text(language(context, item.name ?? ''),
                    style: appCss.dmDenseMedium14
                        .textColor(appColor(context).appTheme.darkText)),
              ],
            );
          },
        ).paddingSymmetric(horizontal: Insets.i20),
      ],
    );
  }

  /// Builds the commission section with percentage display
  Widget _buildCommissionSection(BuildContext context) {
    return Column(
      children: [
        ContainerWithTextLayout(
          title: language(context, appFonts.applicableCommission),
        ).paddingOnly(top: Insets.i24, bottom: Insets.i12),
        _buildCommissionDisplay(context),
        const VSpace(Sizes.s2),
        _buildCommissionNote(context),
      ],
    );
  }

  /// Builds the commission percentage display container
  Widget _buildCommissionDisplay(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: appColor(context).appTheme.stroke,
        shape: RoundedRectangleBorder(
          borderRadius: SmoothBorderRadius(
            cornerRadius: AppRadius.r8,
            cornerSmoothing: 0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                eSvgAssets.commission,
                colorFilter: ColorFilter.mode(
                  appColor(context).appTheme.lightText,
                  BlendMode.srcIn,
                ),
              ),
              const HSpace(Sizes.s10),
              Text(
                "30%",
                style: appCss.dmDenseMedium14.textColor(
                  appColor(context).appTheme.lightText,
                ),
              ),
            ],
          ),
          Text(
            language(context, appFonts.percentage),
            style: appCss.dmDenseRegular12.textColor(
              appColor(context).appTheme.lightText,
            ),
          ),
        ],
      ).paddingAll(Insets.i15),
    );
  }

  /// Builds the commission note text
  Widget _buildCommissionNote(BuildContext context) {
    return Text(
      language(context, appFonts.noteHighest),
      style: appCss.dmDenseMedium12.textColor(
        appColor(context).appTheme.red,
      ),
    );
  }
}
