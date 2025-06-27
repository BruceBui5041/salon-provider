// import '../../../config.dart';

// class LocationListScreen extends StatefulWidget {
//   const LocationListScreen({super.key});

//   @override
//   State<LocationListScreen> createState() => _LocationListScreenState();
// }

// class _LocationListScreenState extends State<LocationListScreen>
//     with TickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<LocationListProvider>(builder: (context, value, child) {
//       return Scaffold(
//           appBar: AppBar(
//               leadingWidth: 80,
//               title: Text(language(context, appFonts.locationList),
//                   style: appCss.dmDenseBold18
//                       .textColor(appColor(context).appTheme.darkText)),
//               centerTitle: true,
//               leading: CommonArrow(
//                   arrow: rtl(context)
//                       ? eSvgAssets.arrowRight
//                       : eSvgAssets.arrowLeft,
//                   onTap: () => route.pop(context)).paddingAll(Insets.i8),
//               actions: [
//                 CommonArrow(
//                         arrow: eSvgAssets.add,
//                         onTap: () =>
//                             route.pushNamed(context, routeName.location))
//                     .paddingOnly(right: Insets.i20)
//               ]),
//           body: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                 Column(children: [
//                   ...value.locationList
//                       .asMap()
//                       .entries
//                       .map((e) => ServicemanListLayout(
//                           isCheck: value.selectedLocation.contains(e.key),
//                           onIconTap: () => value.onTapLocation(e.key, e.value),
//                           isBorder: true,
//                           onEdit: () =>
//                               value.onEditLocation(e.key, e.value, context),
//                           onDelete: () =>
//                               value.onLocationDelete(e.key, context, this),
//                           data: e.value,
//                           index: e.key,
//                           list: value.locationList))
//                       .toList()
//                 ]),
//                 ButtonCommon(
//                     title: appFonts.addSelectLocation,
//                     onTap: () => value.onAddSelectLocation(context),
//                     style: appCss.dmDenseRegular16
//                         .textColor(appColor(context).appTheme.primary),
//                     color: appColor(context).appTheme.trans,
//                     borderColor: appColor(context).appTheme.primary)
//               ])
//               .paddingSymmetric(horizontal: Insets.i20, vertical: Insets.i20));
//     });
//   }
// }
