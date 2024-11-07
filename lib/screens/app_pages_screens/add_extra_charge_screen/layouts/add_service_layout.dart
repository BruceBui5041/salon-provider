import '../../../../config.dart';

class AddServiceLayout extends StatelessWidget {
  const AddServiceLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<AddExtraChargesProvider>(context);
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(value.chargeTitleCtrl.text,
              style: appCss.dmDenseMedium14
                  .textColor(appColor(context).appTheme.darkText)),
          const VSpace(Sizes.s5),
          Text("\$${value.perServiceAmountCtrl.text} per service",
              style: appCss.dmDenseMedium14
                  .textColor(appColor(context).appTheme.primary))
        ]),
        Image.asset(eImageAssets.serviceIcon,
            height: Sizes.s46, width: Sizes.s46)
      ]),
      const DottedLines().paddingSymmetric(vertical: Insets.i12),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(language(context, appFonts.noOfServiceDone),
            style: appCss.dmDenseMedium12
                .textColor(appColor(context).appTheme.darkText)),
        Text(value.val.toString(),
            style: appCss.dmDenseMedium12
                .textColor(appColor(context).appTheme.darkText))
      ])
    ]).paddingAll(Insets.i15).boxBorderExtension(context, isShadow: true);
  }
}
