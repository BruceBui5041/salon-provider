// import 'package:figma_squircle_updated/figma_squircle.dart';
// import 'package:salon_provider/model/response/category_response.dart';
// import 'package:salon_provider/model/response/service_version_response.dart';
// import 'package:salon_provider/providers/app_pages_provider/edit_service_provider.dart';
// import 'package:salon_provider/widgets/dropdown_common.dart';
// import 'package:flutter/cupertino.dart';

// import '../../../../config.dart';

// class FormEditServiceDefaultLayout extends StatefulWidget {
//   const FormEditServiceDefaultLayout({super.key});

//   @override
//   State<FormEditServiceDefaultLayout> createState() =>
//       _FormEditServiceDefaultLayoutState();
// }

// class _FormEditServiceDefaultLayoutState
//     extends State<FormEditServiceDefaultLayout> {
//   @override
//   Widget build(BuildContext context) {
//     final value = Provider.of<EditServiceProvider>(context);
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _serviceImage(context, value),
//         _thumnailImage(context, value),
//         _editorHtml(),
//         const VSpace(Sizes.s8),
//         _categoryDropdown(context, value),
//         _subCategoryDropdown(context, value),
//         _serviceDetail(context, value),
//         _dropdownDraftService(context, value),
//       ],
//     );
//   }

//   Widget _editorHtml() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ContainerWithTextLayout(title: "Mô tả chi tiết")
//             .paddingOnly(top: Insets.i24, bottom: Insets.i12),
//         SizedBox(
//           // height: 300,
//           width: double.infinity,
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: Insets.i15,
//             ),
//             child: TextFieldCommon(
//               hintText: "Nhập mô tả chi tiết",
//               controller: TextEditingController(),
//               focusNode: FocusNode(),
//             ),
//           ),
//         )
//       ],
//     );
//   }

//   Widget _categoryDropdown(BuildContext context, EditServiceProvider value) {
//     return Column(
//       children: [
//         ContainerWithTextLayout(title: language(context, appFonts.categories))
//             .paddingOnly(top: Insets.i24, bottom: Insets.i12),
//         // Padding(
//         //   padding: EdgeInsets.symmetric(
//         //     horizontal: Insets.i15,
//         //   ),
//         //   child: DropDownLayout<CategoryItem>(
//         //     val: value.categoryResponse != null &&
//         //             value.categoryResponse!.data.isNotEmpty
//         //         ? value.categoryResponse?.data.firstWhere((e) =>
//         //             e.id ==
//         //             value.itemService!.serviceVersion!.categoryResponse!.id)
//         //         : null,
//         //     isBig: true,
//         //     isField: true,
//         //     showValue: (val) => Text(language(context, val.name ?? ''),
//         //         style: appCss.dmDenseMedium14.textColor(val.name == null
//         //             ? appColor(context).appTheme.lightText
//         //             : appColor(context).appTheme.darkText)),
//         //     onChanged: (val) => value.onChangeCategory(val),
//         //     list: value.categoryResponse?.data ?? [],
//         //   ),
//         // )
//       ],
//     );
//   }

//   Widget _subCategoryDropdown(BuildContext context, EditServiceProvider value) {
//     return Column(
//       children: [
//         ContainerWithTextLayout(title: language(context, appFonts.subCategory))
//             .paddingOnly(top: Insets.i24, bottom: Insets.i12),
//         // Padding(
//         //   padding: EdgeInsets.symmetric(
//         //     horizontal: Insets.i15,
//         //   ),
//         //   child: DropDownLayout(
//         //     val: value.subCategoryResponse != null &&
//         //             value.subCategoryResponse!.data.isNotEmpty
//         //         ? value.subCategoryResponse?.data.firstWhere((e) =>
//         //             e.id ==
//         //             value.itemService!.serviceVersion!.categoryResponse!.id)
//         //         : null,
//         //     isBig: true,
//         //     isField: true,
//         //     showValue: (val) => Text(language(context, val.name ?? ''),
//         //         style: appCss.dmDenseMedium14.textColor(val.name == null
//         //             ? appColor(context).appTheme.lightText
//         //             : appColor(context).appTheme.darkText)),
//         //     onChanged: (val) => value.onChangeSubCategory(val),
//         //     list: value.subCategoryResponse?.data ?? [],
//         //   ),
//         // )
//       ],
//     );
//   }

//   Widget _thumnailImage(BuildContext context, EditServiceProvider value) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ContainerWithTextLayout(
//                 title: language(context, appFonts.thumbnailImage))
//             .paddingOnly(top: Insets.i24, bottom: Insets.i12),
//         if (value.thumbImage != null && value.thumbImage != "")
//           Container(
//                   height: Sizes.s70,
//                   width: Sizes.s70,
//                   decoration: ShapeDecoration(
//                       image: DecorationImage(
//                           image: AssetImage(value.thumbImage!),
//                           fit: BoxFit.cover),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: SmoothBorderRadius(
//                               cornerRadius: AppRadius.r8, cornerSmoothing: 1))))
//               .paddingSymmetric(horizontal: Insets.i20),
//         if (value.thumbImage == null || value.thumbImage == "")
//           value.thumbFile != null
//               ? AddServiceImageLayout(
//                       image: value.thumbFile!.path,
//                       onDelete: () => value.onRemoveServiceImage(true))
//                   .paddingSymmetric(horizontal: Insets.i20)
//               : AddNewBoxLayout(onAdd: () => value.onImagePick(context, true))
//                   .paddingSymmetric(horizontal: Insets.i20),
//       ],
//     );
//   }

//   Widget _serviceImage(BuildContext context, EditServiceProvider value) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ContainerWithTextLayout(
//             title: language(context,
//                 "${language(context, appFonts.serviceImages)} (${value.image != null && value.image != "" ? "1" : appArray.serviceImageList.length}/5)")),
//         const VSpace(Sizes.s12),
//         Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(children: [
//               if (value.image != null && value.image != "")
//                 Container(
//                         height: Sizes.s70,
//                         width: Sizes.s70,
//                         decoration: ShapeDecoration(
//                             image: DecorationImage(
//                                 image: AssetImage(value.image!),
//                                 fit: BoxFit.cover),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: SmoothBorderRadius(
//                                     cornerRadius: AppRadius.r8,
//                                     cornerSmoothing: 1))))
//                     .paddingOnly(right: Insets.i15),
//               if (value.image == null)
//                 ...appArray.serviceImageList
//                     .asMap()
//                     .entries
//                     .map((e) => AddServiceImageLayout(
//                         image: e.value,
//                         onDelete: () =>
//                             value.onRemoveServiceImage(false, index: e.key)))
//                     .toList(),
//               if (appArray.serviceImageList.length <= 4)
//                 AddNewBoxLayout(onAdd: () => value.onImagePick(context, false))
//             ]),
//           ),
//           const VSpace(Sizes.s8),
//           Text(language(context, appFonts.theMaximumImage),
//               style: appCss.dmDenseRegular12
//                   .textColor(appColor(context).appTheme.lightText))
//         ]).paddingSymmetric(horizontal: Insets.i20),
//       ],
//     );
//   }

//   Widget _serviceDetail(BuildContext context, EditServiceProvider value) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _slugInput(context, value),
//         const VSpace(Sizes.s8),
//         _titleInput(value),
//         const VSpace(Sizes.s8),
//         _durationInput(value),
//         const VSpace(Sizes.s8),
//         _priceInput(value),
//         const VSpace(Sizes.s8),
//         _discountedPriceInput(value),
//       ],
//     );
//   }

//   Widget _slugInput(BuildContext context, EditServiceProvider value) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ContainerWithTextLayout(title: "Slug")
//             .paddingOnly(top: Insets.i24, bottom: Insets.i12),
//         TextFieldCommon(
//           focusNode: value.slugFocus,
//           controller: value.slugController,
//           onChanged: (val) {
//             value.convertToSlug(val);
//           },
//           hintText: "Nhập slug",
//         ).paddingSymmetric(horizontal: Insets.i20),
//         if (value.slug.toString().isNotEmpty)
//           Padding(
//             padding: const EdgeInsets.only(left: Insets.i20),
//             child: Text(language(context, value.slug),
//                     style: appCss.dmDenseRegular12
//                         .textColor(appColor(context).appTheme.lightText))
//                 .paddingSymmetric(horizontal: Insets.i20),
//           ),
//       ],
//     );
//   }

//   Widget _titleInput(EditServiceProvider value) {
//     return Column(
//       children: [
//         ContainerWithTextLayout(title: "Nhập tiêu đề")
//             .paddingOnly(top: Insets.i24, bottom: Insets.i12),
//         TextFieldCommon(
//           focusNode: value.titleFocus,
//           controller: value.titleController,
//           hintText: "Nhập tiêu đề",
//         ).paddingSymmetric(horizontal: Insets.i20),
//       ],
//     );
//   }

//   Widget _priceInput(EditServiceProvider value) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ContainerWithTextLayout(title: "Giá")
//             .paddingOnly(top: Insets.i24, bottom: Insets.i12),
//         TextFieldCommon(
//           focusNode: value.priceFocus,
//           controller: value.priceController,
//           hintText: "Nhập giá",
//         ).paddingSymmetric(horizontal: Insets.i20),
//       ],
//     );
//   }

//   Widget _discountedPriceInput(EditServiceProvider value) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ContainerWithTextLayout(title: "Giá giảm")
//             .paddingOnly(top: Insets.i24, bottom: Insets.i12),
//         TextFieldCommon(
//           focusNode: value.discountedPriceFocus,
//           controller: value.discountedPriceController,
//           hintText: "Nhập giá giảm",
//         ).paddingSymmetric(horizontal: Insets.i20),
//       ],
//     );
//   }

//   Widget _durationInput(EditServiceProvider value) {
//     return TimeDropdown(
//       initValue: value.itemService?.serviceVersion!.duration,
//       onChanged: (val) {
//         Provider.of<EditServiceProvider>(context, listen: false)
//             .onChangeDuration(val);
//       },
//     );
//   }

//   Widget _dropdownDraftService(
//       BuildContext context, EditServiceProvider value) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ContainerWithTextLayout(title: "Draft Service")
//             .paddingOnly(top: Insets.i24, bottom: Insets.i12),
//         Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: Insets.i15,
//             ),
//             child: DropDownCommon<ServiceVersion>(
//               list: value.itemService?.versionsResponse!,

//               itemLabel: (item) =>
//                   "${item.title} (${item.publishedDate != null ? "Published" : "Draft"})",
//               // itemImage: (item) => item.,
//               onChanged: (newValue) {

//                 Provider.of<EditServiceProvider>(context, listen: false)
//                     .onCraftSelected(newValue!);
//                 Provider.of<EditServiceProvider>(context, listen: false)
//                     .onShowDraft(
//                         newValue!.publishedDate != null ? false : true);
//               },
//             )),
//       ],
//     );
//   }
// }

// // class MyEditorWidget extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     final controller = QuillEditorController();
// //     return Column(
// //       children: [
// //         QuillHtmlEditor(
// //           controller: controller,
// //           text: "<h1>Hello</h1>",
// //           hintText: 'Nhập văn bản tại đây',
// //           minHeight: 300,
// //         ),
// //         ToolBar(
// //           controller: controller,
// //           toolBarColor: Colors.cyan.shade50,
// //           activeIconColor: Colors.green,
// //         ),
// //       ],
// //     );
// //   }
// // }

// class TimeDropdown extends StatefulWidget {
//   const TimeDropdown({super.key, this.onChanged, this.initValue});
//   final Function(int)? onChanged;
//   final int? initValue;
//   @override
//   _TimeDropdownState createState() => _TimeDropdownState();
// }

// class _TimeDropdownState extends State<TimeDropdown> {
//   int? _selectedItem;
//   int? _minutes;

//   final List<int> _timeItems = [15, 30, 60, 120, 180, 300];

//   @override
//   void initState() {
//     _selectedItem = widget.initValue;
//     super.initState();
//   }

//   String convertToLabel(int time) {
//     if (time < 60) {
//       return '$time phút';
//     } else {
//       int hours = time ~/ 60;
//       int minutes = time % 60;
//       if (minutes == 0) {
//         return '$hours giờ';
//       } else {
//         return '$hours giờ $minutes phút';
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ContainerWithTextLayout(title: "Thời gian thực hiện")
//             .paddingOnly(top: Insets.i24, bottom: Insets.i12),
//         const SizedBox(height: 10),
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: Insets.i20),
//           width: MediaQuery.of(context).size.width,
//           decoration: BoxDecoration(color: Colors.white),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               DropdownButton<int>(
//                 value: _selectedItem,
//                 hint: Text('Chọn thời gian'),
//                 items: _timeItems.map((int value) {
//                   return DropdownMenuItem<int>(
//                     value: value,
//                     child: Text(convertToLabel(value)),
//                   );
//                 }).toList(),
//                 onChanged: (int? newValue) {
//                   setState(() {
//                     _selectedItem = newValue;
//                     if (newValue != null) {
//                       widget.onChanged?.call(newValue);
//                     }
//                   });
//                 },
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
