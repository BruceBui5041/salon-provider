import 'package:figma_squircle_updated/figma_squircle.dart';
import 'package:flutter/cupertino.dart';

import '../../../../config.dart';

class FormServiceDefaultLayout extends StatelessWidget {
  const FormServiceDefaultLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<AddNewServiceProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _serviceImage(context, value),
        _thumnailImage(context, value),
        _editorHtml(),
        const VSpace(Sizes.s8),
        _categoryDropdown(context, value),
        _subCategoryDropdown(context, value),
        _serviceDetail(context, value),
      ],
    );
  }

  Widget _editorHtml() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContainerWithTextLayout(title: "Mô tả chi tiết")
            .paddingOnly(top: Insets.i24, bottom: Insets.i12),
        SizedBox(
          // height: 300,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Insets.i15,
            ),
            child: TextFieldCommon(
              hintText: "Nhập mô tả chi tiết",
              controller: TextEditingController(),
              focusNode: FocusNode(),
            ),
          ),
        )
      ],
    );
  }

  Widget _categoryDropdown(BuildContext context, AddNewServiceProvider value) {
    return Column(
      children: [
        ContainerWithTextLayout(title: language(context, appFonts.categories))
            .paddingOnly(top: Insets.i24, bottom: Insets.i12),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Insets.i15,
          ),
          child: DropDownLayout(
            isBig: true,
            isField: true,
            onChanged: (val) => value.onChangeCategory(val),
            list: value.categoryResponse?.data ?? [],
          ),
        )
      ],
    );
  }

  Widget _subCategoryDropdown(
      BuildContext context, AddNewServiceProvider value) {
    return Column(
      children: [
        ContainerWithTextLayout(title: language(context, appFonts.subCategory))
            .paddingOnly(top: Insets.i24, bottom: Insets.i12),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Insets.i15,
          ),
          child: DropDownLayout(
            isBig: true,
            isField: true,
            onChanged: (val) => value.onChangeSubCategory(val),
            list: value.subCategoryResponse?.data ?? [],
          ),
        )
      ],
    );
  }

  Widget _thumnailImage(BuildContext context, AddNewServiceProvider value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContainerWithTextLayout(
                title: language(context, appFonts.thumbnailImage))
            .paddingOnly(top: Insets.i24, bottom: Insets.i12),
        if (value.thumbImage != null && value.thumbImage != "")
          Container(
                  height: Sizes.s70,
                  width: Sizes.s70,
                  decoration: ShapeDecoration(
                      image: DecorationImage(
                          image: AssetImage(value.thumbImage!),
                          fit: BoxFit.cover),
                      shape: RoundedRectangleBorder(
                          borderRadius: SmoothBorderRadius(
                              cornerRadius: AppRadius.r8, cornerSmoothing: 1))))
              .paddingSymmetric(horizontal: Insets.i20),
        if (value.thumbImage == null || value.thumbImage == "")
          value.thumbFile != null
              ? AddServiceImageLayout(
                      image: value.thumbFile!.path,
                      onDelete: () => value.onRemoveServiceImage(true))
                  .paddingSymmetric(horizontal: Insets.i20)
              : AddNewBoxLayout(onAdd: () => value.onImagePick(context, true))
                  .paddingSymmetric(horizontal: Insets.i20),
      ],
    );
  }

  Widget _serviceImage(BuildContext context, AddNewServiceProvider value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContainerWithTextLayout(
            title: language(context,
                "${language(context, appFonts.serviceImages)} (${value.image != null && value.image != "" ? "1" : appArray.serviceImageList.length}/5)")),
        const VSpace(Sizes.s12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              if (value.image != null && value.image != "")
                Container(
                        height: Sizes.s70,
                        width: Sizes.s70,
                        decoration: ShapeDecoration(
                            image: DecorationImage(
                                image: AssetImage(value.image!),
                                fit: BoxFit.cover),
                            shape: RoundedRectangleBorder(
                                borderRadius: SmoothBorderRadius(
                                    cornerRadius: AppRadius.r8,
                                    cornerSmoothing: 1))))
                    .paddingOnly(right: Insets.i15),
              if (value.image == null)
                ...appArray.serviceImageList
                    .asMap()
                    .entries
                    .map((e) => AddServiceImageLayout(
                        image: e.value,
                        onDelete: () =>
                            value.onRemoveServiceImage(false, index: e.key)))
                    .toList(),
              if (appArray.serviceImageList.length <= 4)
                AddNewBoxLayout(onAdd: () => value.onImagePick(context, false))
            ]),
          ),
          const VSpace(Sizes.s8),
          Text(language(context, appFonts.theMaximumImage),
              style: appCss.dmDenseRegular12
                  .textColor(appColor(context).appTheme.lightText))
        ]).paddingSymmetric(horizontal: Insets.i20),
      ],
    );
  }

  Widget _serviceDetail(BuildContext context, AddNewServiceProvider value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContainerWithTextLayout(
                title: language(context, appFonts.serviceDetail))
            .paddingOnly(top: Insets.i24, bottom: Insets.i12),
        _slugInput(context, value),
        const VSpace(Sizes.s8),
        _titleInput(value),
        const VSpace(Sizes.s8),
        _durationInput(context, value),
        const VSpace(Sizes.s8),
        _priceInput(value),
        const VSpace(Sizes.s8),
        _discountedPriceInput(value),
      ],
    );
  }

  Widget _slugInput(BuildContext context, AddNewServiceProvider value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContainerWithTextLayout(title: "Slug")
            .paddingOnly(top: Insets.i24, bottom: Insets.i12),
        TextFieldCommon(
          focusNode: value.slugFocus,
          controller: value.slugController,
          onChanged: (val) {
            value.convertToSlug(val);
          },
          hintText: "Nhập slug",
        ).paddingSymmetric(horizontal: Insets.i20),
        if (value.slug.toString().isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: Insets.i20),
            child: Text(language(context, value.slug),
                    style: appCss.dmDenseRegular12
                        .textColor(appColor(context).appTheme.lightText))
                .paddingSymmetric(horizontal: Insets.i20),
          ),
      ],
    );
  }

  Widget _titleInput(AddNewServiceProvider value) {
    return Column(
      children: [
        ContainerWithTextLayout(title: "Nhập tiêu đề")
            .paddingOnly(top: Insets.i24, bottom: Insets.i12),
        TextFieldCommon(
          focusNode: value.titleFocus,
          controller: value.titleController,
          hintText: "Nhập tiêu đề",
        ).paddingSymmetric(horizontal: Insets.i20),
      ],
    );
  }

  Widget _priceInput(AddNewServiceProvider value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContainerWithTextLayout(title: "Giá")
            .paddingOnly(top: Insets.i24, bottom: Insets.i12),
        TextFieldCommon(
          focusNode: value.priceFocus,
          controller: value.priceController,
          hintText: "Nhập giá",
        ).paddingSymmetric(horizontal: Insets.i20),
      ],
    );
  }

  Widget _discountedPriceInput(AddNewServiceProvider value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContainerWithTextLayout(title: "Giá giảm")
            .paddingOnly(top: Insets.i24, bottom: Insets.i12),
        TextFieldCommon(
          focusNode: value.discountedPriceFocus,
          controller: value.discountedPriceController,
          hintText: "Nhập giá giảm",
        ).paddingSymmetric(horizontal: Insets.i20),
      ],
    );
  }

  Widget _durationInput(BuildContext context, AddNewServiceProvider value) {
    return TimeDropdown(
      onChanged: (p0) {
        Provider.of<AddNewServiceProvider>(context, listen: false)
            .onChangeDuration(p0);
      },
    );
  }
}

// class MyEditorWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final controller = QuillEditorController();
//     return Column(
//       children: [
//         QuillHtmlEditor(
//           controller: controller,
//           text: "<h1>Hello</h1>",
//           hintText: 'Nhập văn bản tại đây',
//           minHeight: 300,
//         ),
//         ToolBar(
//           controller: controller,
//           toolBarColor: Colors.cyan.shade50,
//           activeIconColor: Colors.green,
//         ),
//       ],
//     );
//   }
// }

class TimeDropdown extends StatefulWidget {
  const TimeDropdown({super.key, this.onChanged});
  final Function(int)? onChanged;
  @override
  _TimeDropdownState createState() => _TimeDropdownState();
}

class _TimeDropdownState extends State<TimeDropdown> {
  String? _selectedItem;
  int? _minutes;

  final List<String> _timeItems = ['15p', '30p', '1h', '2h', '3h', '5h'];

  // Hàm chuyển đổi giá trị thành số phút
  int convertToMinutes(String time) {
    if (time.endsWith('p')) {
      return int.parse(time.replaceAll('p', ''));
    } else if (time.endsWith('h')) {
      return int.parse(time.replaceAll('h', '')) * 60;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContainerWithTextLayout(title: "Thời gian thực hiện")
            .paddingOnly(top: Insets.i24, bottom: Insets.i12),
        const SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: Insets.i20),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                value: _selectedItem,
                hint: Text('Chọn thời gian'),
                items: _timeItems.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedItem = newValue;
                    widget.onChanged?.call(convertToMinutes(newValue!));
                    _minutes =
                        newValue != null ? convertToMinutes(newValue) : null;
                  });
                },
              ),
              if (_minutes != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                  child: Text('Số phút: $_minutes'),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
