import '../../../config.dart';

class BankDetailScreen extends StatelessWidget {
  const BankDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BankDetailProvider>(builder: (context, value, child) {
      return Scaffold(
          appBar: AppBarCommon(title: appFonts.bankDetails),
          body: SingleChildScrollView(
              child: Column(children: [
            Stack(children: [
              const FieldsBackground(),
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ContainerWithTextLayout(
                        title: language(context, appFonts.bankName)),
                    const VSpace(Sizes.s8),
                    TextFieldCommon(
                            focusNode: value.bankNameFocus,
                            controller: value.bankNameCtrl,
                            hintText: appFonts.bankName,
                            prefixIcon: eSvgAssets.bank)
                        .paddingSymmetric(horizontal: Insets.i20),
                    ContainerWithTextLayout(title: appFonts.holderName)
                        .paddingOnly(top: Insets.i10, bottom: Insets.i5),
                    TextFieldCommon(
                        focusNode: value.holdNameFocus,
                            controller: value.holderNameCtrl,
                            hintText: appFonts.holderName,
                            prefixIcon: eSvgAssets.profile)
                        .paddingSymmetric(horizontal: Insets.i20),
                    ContainerWithTextLayout(title: appFonts.accountNo)
                        .paddingOnly(top: Insets.i10, bottom: Insets.i5),
                    TextFieldCommon(
                        focusNode: value.accountFocus,
                            controller: value.accountCtrl,
                            hintText: appFonts.accountNo,
                            prefixIcon: eSvgAssets.account)
                        .paddingSymmetric(horizontal: Insets.i20),
                    ContainerWithTextLayout(title: appFonts.branchName)
                        .paddingOnly(top: Insets.i10, bottom: Insets.i5),
                    DropDownLayout(
                            icon: eSvgAssets.bank,
                            val: value.branchValue,
                            hintText: appFonts.branchName,
                            isIcon: true,
                            categoryList: appArray.branchList,
                            onChanged: (val) => value.onBranch(val))
                        .paddingSymmetric(horizontal: Insets.i20),
                    ContainerWithTextLayout(title: appFonts.ifscCode)
                        .paddingOnly(top: Insets.i10, bottom: Insets.i5),
                    TextFieldCommon(
                        focusNode: value.ifscFocus,
                            controller: value.ifscCtrl,
                            hintText: appFonts.ifscCode,
                            prefixIcon: eSvgAssets.identity)
                        .paddingSymmetric(horizontal: Insets.i20),
                    ContainerWithTextLayout(title: appFonts.swiftCode)
                        .paddingOnly(top: Insets.i10, bottom: Insets.i5),
                    TextFieldCommon(
                        focusNode: value.swiftFocus,
                            controller: value.swiftCtrl,
                            hintText: appFonts.swiftCode,
                            prefixIcon: eSvgAssets.identity)
                        .paddingSymmetric(horizontal: Insets.i20),
                  ]).paddingSymmetric(vertical: Insets.i20)
            ]),
            ButtonCommon(title: appFonts.update,onTap: ()=> route.pop(context)).paddingOnly(bottom: Insets.i10, top: Insets.i40)
          ]).paddingAll(Insets.i20)));
    });
  }
}
