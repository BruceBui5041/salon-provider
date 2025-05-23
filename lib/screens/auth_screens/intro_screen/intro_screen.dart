import 'package:flutter/gestures.dart';

import '../../../config.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<IntroProvider>(builder: (context, value, child) {
      return PopScope(
        canPop: false,
        child: Scaffold(
            body: Column(children: [
          Stack(children: [
            Image.asset(eImageAssets.introImage,
                height: Sizes.s470,
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width),
            const LanguageDropDownLayout()
                .paddingSymmetric(vertical: Insets.i50, horizontal: Insets.i20)
          ]),
          Column(children: [
            const SizedBox(height: Sizes.s2, width: Sizes.s24).decorated(
                color: appColor(context).appTheme.primary,
                borderRadius:
                    const BorderRadius.all(Radius.circular(AppRadius.r10))),
            const VSpace(Sizes.s13),
            Text(language(context, appFonts.getPaidBy).toUpperCase(),
                style: appCss.dmDenseBold15
                    .textColor(appColor(context).appTheme.darkText)),
            const VSpace(Sizes.s13),
            Text(language(context, appFonts.nowManageAll),
                textAlign: TextAlign.center,
                style: appCss.dmDenseMedium14
                    .textColor(appColor(context).appTheme.lightText)),
            const VSpace(Sizes.s25),
            ButtonCommon(
                title: appFonts.loginAsProvider,
                onTap: () => route.pushNamed(context, routeName.loginProvider)),
            const VSpace(Sizes.s15),
            Text(language(context, appFonts.loginAsServiceman),
                    textAlign: TextAlign.center,
                    style: appCss.dmDenseMedium16
                        .textColor(appColor(context).appTheme.primary))
                .inkWell(
                    onTap: () =>
                        route.pushNamed(context, routeName.loginServiceman))
          ])
              .paddingSymmetric(vertical: Insets.i15, horizontal: Insets.i20)
              .boxShapeExtension(
                  color: appColor(context).appTheme.fieldCardBg,
                  radius: AppRadius.r20)
              .paddingSymmetric(horizontal: Insets.i20),
          const VSpace(Sizes.s15),
          Consumer<IntroProvider>(builder: (context, value, child) {
            return RichText(
                text: TextSpan(
                    text: language(context, appFonts.donHaveAccount),
                    style: appCss.dmDenseMedium14
                        .textColor(appColor(context).appTheme.darkText),
                    children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => value.onSignUp(context),
                      text: language(context, appFonts.signUp),
                      style: appCss.dmDenseMedium12
                          .textColor(appColor(context).appTheme.primary))
                ]));
          })
        ])),
      );
    });
  }
}
