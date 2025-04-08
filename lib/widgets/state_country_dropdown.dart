// import 'package:dropdown_search/dropdown_search.dart';

// import '../config.dart';

// class StateCountryDropdown extends StatelessWidget {
//   final String? icon;
//   final ValueChanged? onChanged;
//   final List? items;
//   final dynamic selectedItem;


//   const StateCountryDropdown({super.key, this.onChanged, this.items, this.selectedItem, this.icon});

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: ThemeData(
//           dropdownMenuTheme: const DropdownMenuThemeData(
//               inputDecorationTheme:
//               InputDecorationTheme(fillColor: Colors.cyan))),
//       child: DropdownSearch(
//         dropdownBuilder:(context,_) {
//              DropdownButtonProps(
//             icon: SvgPicture.asset(eSvgAssets.dropDown,
//                 colorFilter: ColorFilter.mode( selectedItem != null ? appColor(context).appTheme.darkText :
//                     appColor(context).appTheme.lightText,
//                     BlendMode.srcIn)))
//         },
//         popupProps: const PopupProps.menu(
//             showSearchBox: true,searchFieldProps: TextFieldProps(
//             decoration: InputDecoration(
//                 contentPadding: EdgeInsets.zero
//             )
//         )
//         ),
//         onChanged: onChanged,
//         items: items!,
//         selectedItem: selectedItem,
//         filterFn: (item, filter) {
//           return item.title.toString().toLowerCase().contains(filter);
//         },
//         itemAsString: (item) => item.title,
//        /* dropdownBuilder: (context, selectedItem) =>
//             Text(selectedItem.title),*/
//         dropdownDecoratorProps: DropDownDecoratorProps(
//             dropdownSearchDecoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(vertical: 10),
//                 prefixIcon: SvgPicture.asset( icon ?? eSvgAssets.country,
//                     fit: BoxFit.scaleDown,
//                     colorFilter: ColorFilter.mode( selectedItem != null ? appColor(context).appTheme.darkText :
//                     appColor(context).appTheme.lightText,
//                         BlendMode.srcIn)),
//                 fillColor: appColor(context).appTheme.whiteColor,
//                 filled: true,
//                 hintStyle: appCss.dmDenseRegular14.textColor(appColor(context).appTheme.lightText),
//                 hintText: language(context, appFonts.search),
//                 enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(AppRadius.r8),
//                     borderSide: BorderSide.none),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(AppRadius.r8),
//                     borderSide: BorderSide.none),
//                 focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(AppRadius.r8),
//                     borderSide: BorderSide.none),
//                 disabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(AppRadius.r8),
//                     borderSide: BorderSide.none)))
//       )
//     );
//   }
// }
