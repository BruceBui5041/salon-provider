// import 'package:figma_squircle_updated/figma_squircle.dart';
// import 'package:salon_provider/widgets/wallet_drop_down.dart';

// import '../../../../config.dart';

// class AddMoneyLayout extends StatefulWidget {
//   const AddMoneyLayout({super.key});

//   @override
//   State<AddMoneyLayout> createState() => _AddMoneyLayoutState();
// }

// class _AddMoneyLayoutState extends State<AddMoneyLayout> {
//   String? _chosenValue;
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<WalletProvider>(builder: (context, value, child) {
//       return Padding(
//         padding:
//             EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//         child: Container(
//             height: MediaQuery.of(context).size.height / 2,
//             width: MediaQuery.of(context).size.width,
//             decoration: ShapeDecoration(
//                 shape: const SmoothRectangleBorder(
//                     borderRadius: SmoothBorderRadius.only(
//                         topLeft: SmoothRadius(
//                             cornerRadius: AppRadius.r20, cornerSmoothing: 1),
//                         topRight: SmoothRadius(
//                             cornerRadius: AppRadius.r20,
//                             cornerSmoothing: 0.4))),
//                 color: appColor(context).appTheme.whiteBg),
//             child: SingleChildScrollView(
//                 child: Column(children: [
//               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                 Text(language(context, appFonts.addMoney),
//                     style: appCss.dmDenseMedium18
//                         .textColor(appColor(context).appTheme.darkText)),
//                 SvgPicture.asset(eSvgAssets.cross)
//                     .inkWell(onTap: () => route.pop(context))
//               ]).paddingAll(Insets.i20),
//               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                 Text(language(context, appFonts.addForm),
//                     style: appCss.dmDenseMedium14
//                         .textColor(appColor(context).appTheme.darkText)),
//                 const VSpace(Sizes.s8),
//                 /*DropDownLayout(
//                       isListIcon: true,
//                         icon: eSvgAssets.wallet,
//                         val: value.countryValue,
//                         hintText: appFonts.selectPaymentGateway,
//                         isIcon: true,
//                         categoryList: appArray.paymentGatewayList,
//                         onChanged: (val) => value.onTapGateway(val))*/
//                 WalletDropDown(
//                     icon: eSvgAssets.wallet,
//                     val: value.countryValue,
//                     isIcon: true,
//                     categoryList: appArray.paymentGatewayList,
//                     onChanged: (val) => value.onTapGateway(val)),
//                 const VSpace(Sizes.s20),
//                 Text(language(context, appFonts.amount),
//                     style: appCss.dmDenseMedium14
//                         .textColor(appColor(context).appTheme.darkText)),
//                 const VSpace(Sizes.s8),
//                 TextFieldCommon(
//                     keyboardType: TextInputType.number,
//                     focusNode: value.amountFocus,
//                     controller: value.amountCtrl,
//                     hintText: appFonts.enterAmount,
//                     prefixIcon: eSvgAssets.dollar)
//               ])
//                   .paddingSymmetric(
//                       vertical: Insets.i20, horizontal: Insets.i15)
//                   .boxShapeExtension(
//                       color: appColor(context).appTheme.fieldCardBg)
//                   .paddingSymmetric(horizontal: Insets.i20),
//               const VSpace(Sizes.s30),
//               Row(children: [
//                 Expanded(
//                     child: ButtonCommon(
//                         onTap: () => route.pop(context),
//                         title: appFonts.cancel,
//                         color: appColor(context).appTheme.whiteBg,
//                         borderColor: appColor(context).appTheme.primary,
//                         style: appCss.dmDenseSemiBold16
//                             .textColor(appColor(context).appTheme.primary))),
//                 const HSpace(Sizes.s15),
//                 Expanded(
//                     child: ButtonCommon(
//                         title: appFonts.addMoney,
//                         onTap: () => route.pop(context)))
//               ]).paddingSymmetric(horizontal: Insets.i20)
//             ]))),
//       );
//     });
//   }
// }
