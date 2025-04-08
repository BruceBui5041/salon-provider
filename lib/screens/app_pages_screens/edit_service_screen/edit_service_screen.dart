// import 'package:salon_provider/providers/app_pages_provider/all_service_provider.dart';
// import 'package:salon_provider/providers/app_pages_provider/edit_service_provider.dart';
// import 'package:salon_provider/screens/app_pages_screens/add_new_service_screen/layouts/form_default_layout.dart';
// import 'package:salon_provider/screens/app_pages_screens/edit_service_screen/layout/edit_service_layout.dart';

// import '../../../config.dart';

// class EditServiceScreen extends StatefulWidget {
//   const EditServiceScreen({super.key});

//   @override
//   State<EditServiceScreen> createState() => _EditServiceScreenState();
// }

// class _EditServiceScreenState extends State<EditServiceScreen> {
//   @override
//   void initState() {
//     Provider.of<EditServiceProvider>(context, listen: false).fetchCategory();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     Provider.of<EditServiceProvider>(context, listen: false).clearInput();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<EditServiceProvider>(builder: (context1, value, child) {
//       bool? isCanSetDraft = value.itemService?.versionsResponse
//           ?.where((e) => e.publishedDate == null)
//           .toList()
//           .isEmpty;
//       if (value.showDraft!) {
//         isCanSetDraft = true;
//       }
//       return StatefulWrapper(
//         onInit: () => Future.delayed(
//             const Duration(milliseconds: 500), () => value.initData()),
//         child: PopScope(
//           canPop: true,
//           child: Scaffold(
//               appBar: AppBarCommon(
//                   title: appFonts.editService,
//                   onTap: () {
//                     Navigator.of(context).pop();
//                   }),
//               body: SingleChildScrollView(
//                   child: Column(children: [
//                 Stack(children: [
//                   const FieldsBackground(),
//                   const Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         FormEditServiceDefaultLayout(),
//                       ]).paddingSymmetric(vertical: Insets.i20)
//                 ]),
//                 if (value.showDraft!)
//                   Row(
//                     children: [
//                       if (!isCanSetDraft!)
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.only(right: Insets.i10),
//                             child: ButtonCommon(
//                                 color: Colors.red,
//                                 title: "New draft",
//                                 onTap: () {
//                                   value.publishService(callBack: () {
//                                     Navigator.of(context).pop();
//                                   });
//                                 }).paddingOnly(
//                               bottom: Insets.i10,
//                             ),
//                           ),
//                         ),
//                       if (isCanSetDraft)
//                         Expanded(
//                           child: ButtonCommon(
//                               color: Colors.red,
//                               title: "Save",
//                               onTap: () {
//                                 value.updateServiceCraft(callBack: () {
//                                   Navigator.of(context).pop();
//                                 });
//                               }).paddingOnly(
//                             // top: Insets.i40,
//                             bottom: Insets.i10,
//                           ),
//                         ),
//                     ],
//                   ),
//                 if (isCanSetDraft!)
//                   ButtonCommon(
//                       color: Colors.green,
//                       title: "Publish",
//                       onTap: () {
//                         value.publishService(callBack: () {
//                           Provider.of<AllServiceProvider>(context,
//                                   listen: false)
//                               .getAllServices();
//                           Navigator.of(context).pop();
//                         });
//                       }).paddingOnly(bottom: Insets.i30)
//               ]).paddingSymmetric(horizontal: Insets.i20))),
//         ),
//       );
//     });
//   }
// }
