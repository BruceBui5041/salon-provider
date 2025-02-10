import 'package:fixit_provider/providers/auth_provider/register_provider.dart';
import 'package:flutter/gestures.dart';
import '../../../../config.dart';

class RegisterScreen extends StatelessWidget {
  final bool? isProvider;
  final GestureTapCallback? onForget;
  final GestureRecognizer? recognizer;
  const RegisterScreen(
      {super.key, this.isProvider = false, this.onForget, this.recognizer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const AuthAppBarCommon(),
      body: Consumer<RegisterProvider>(builder: (context1, value, child) {
        return Stack(children: [
          const FieldsBackground(),
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VSpace(Sizes.s15),
                Row(children: [
                  const SmallContainer(),
                  const HSpace(Sizes.s20),
                  Text(appFonts.firstName,
                      style: appCss.dmDenseSemiBold14
                          .textColor(appColor(context).appTheme.darkText))
                ]),
                const VSpace(Sizes.s8),
                TextFieldCommon(
                        controller: value.firstNameController,
                        hintText: language(context, appFonts.enterFirstName),
                        focusNode: value.firstNameFocus,
                        prefixIcon: eSvgAssets.profile)
                    .paddingSymmetric(horizontal: Insets.i20),
                const VSpace(Sizes.s10),
                Row(children: [
                  const SmallContainer(),
                  const HSpace(Sizes.s20),
                  Text(language(context, appFonts.lastName),
                      style: appCss.dmDenseSemiBold14
                          .textColor(appColor(context).appTheme.darkText))
                ]),
                TextFieldCommon(
                        controller: value.lastNameController,
                        hintText: language(context, appFonts.enterLastName),
                        focusNode: value.lastNameFocus,
                        prefixIcon: eSvgAssets.profile)
                    .paddingSymmetric(horizontal: Insets.i20),
                const VSpace(Sizes.s10),
                Row(children: [
                  const SmallContainer(),
                  const HSpace(Sizes.s20),
                  Text(language(context, appFonts.phone),
                      style: appCss.dmDenseSemiBold14
                          .textColor(appColor(context).appTheme.darkText))
                ]),
                TextFieldCommon(
                        controller: value.phoneController,
                        hintText: language(context, appFonts.enterPhone),
                        focusNode: value.phoneFocus,
                        prefixIcon: eSvgAssets.phone)
                    .paddingSymmetric(horizontal: Insets.i20),
                const VSpace(Sizes.s10),
                ButtonCommon(
                    title: appFonts.loginNow,
                    onTap: () {
                      value.onRegister(context);
                    }).paddingSymmetric(horizontal: Insets.i20),
              ]).paddingSymmetric(vertical: Insets.i20)
        ]);
      }),
    );
  }
}
