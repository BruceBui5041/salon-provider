import 'package:flutter/gestures.dart';
import '../../../../config.dart';

class LoginLayout extends StatelessWidget {
  final bool? isProvider;
  final GestureTapCallback? onForget;
  final GestureRecognizer? recognizer;
  const LoginLayout(
      {super.key, this.isProvider = false, this.onForget, this.recognizer});

  @override
  Widget build(BuildContext context) {
    return Consumer2<LoginAsProvider, LoginAsServicemanProvider>(
        builder: (context1, value, value2, child) {
      return Stack(children: [
        const FieldsBackground(),
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(children: [
              //   const SmallContainer(),
              //   const HSpace(Sizes.s20),
              //   Text(language(context, appFonts.email),
              //       style: appCss.dmDenseSemiBold14
              //           .textColor(appColor(context).appTheme.darkText))
              // ]),
              // const VSpace(Sizes.s8),
              // TextFieldCommon(
              //         validator: (email) =>
              //             Validation().emailValidation(context, email),
              //         controller: isProvider == true ? value.emailController : value2.emailController ,
              //         hintText: language(context, appFonts.enterEmail),
              //         focusNode: value.emailFocus,
              //         onFieldSubmitted: (val) => validation.fieldFocusChange(
              //             context, isProvider == true ? value.emailFocus : value2.emailFocus, isProvider == true ? value.passwordFocus : value2.passwordFocus),
              //         prefixIcon: eSvgAssets.email)
              //     .paddingSymmetric(horizontal: Insets.i20),
              const VSpace(Sizes.s15),
              Row(children: [
                const SmallContainer(),
                const HSpace(Sizes.s20),
                Text(language(context, appFonts.phone),
                    style: appCss.dmDenseSemiBold14
                        .textColor(appColor(context).appTheme.darkText))
              ]),
              const VSpace(Sizes.s8),
              // TextFieldCommon(
              //         validator: (pass) =>
              //             Validation().passValidation(context, pass),
              //         controller: isProvider == true
              //             ? value.passwordController
              //             : value2.passwordController,
              //         hintText: language(context, appFonts.enterPassword),
              //         focusNode: isProvider == true
              //             ? value.passwordFocus
              //             : value2.passwordFocus,
              //         prefixIcon: eSvgAssets.lock)
              //     .paddingSymmetric(horizontal: Insets.i20),
              TextFieldCommon(
                      controller: isProvider == true
                          ? value.phoneController
                          : value2.phoneController,
                      hintText: language(context, appFonts.enterPhone),
                      focusNode: value.phoneFocus,
                      prefixIcon: eSvgAssets.phone)
                  .paddingSymmetric(horizontal: Insets.i20),
              const VSpace(Sizes.s10),
              Text(language(context, appFonts.forgotPassword),
                      style: appCss.dmDenseSemiBold14
                          .textColor(appColor(context).appTheme.primary))
                  .inkWell(onTap: onForget)
                  .alignment(Alignment.bottomRight)
                  .paddingSymmetric(horizontal: Insets.i20),
              const VSpace(Sizes.s35),
              ButtonCommon(
                  title: appFonts.loginNow,
                  onTap: () {
                    if (isProvider == true) {
                      value.onLogin(context);
                    } else {
                      value2.onLogin(context);
                    }
                  }).paddingSymmetric(horizontal: Insets.i20),
              if (isProvider == true)
                RichText(
                    text: TextSpan(
                        text: language(context, appFonts.notMember),
                        style: appCss.dmDenseMedium14
                            .textColor(appColor(context).appTheme.darkText),
                        children: [
                      TextSpan(
                          recognizer: recognizer,
                          text: language(context, appFonts.signUp),
                          style: appCss.dmDenseMedium12
                              .textColor(appColor(context).appTheme.primary))
                    ])).paddingOnly(top: Insets.i12).alignment(Alignment.center)
            ]).paddingSymmetric(vertical: Insets.i20)
      ]);
    });
  }
}
