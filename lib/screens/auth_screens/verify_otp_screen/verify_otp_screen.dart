import '../../../config.dart';

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<VerifyOtpProvider>(builder: (context1, otpCtrl, child) {
      return LoadingComponent(
          child: StatefulWrapper(
              onInit: () {},
              child: Scaffold(
                appBar: const AppBarCommon(title: ""),
                  body: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                                      AuthTopLayout(
                    image: eImageAssets.mailVerify,
                    title: appFonts.verifyOtp,
                    subTitle: appFonts.enterTheCode,
                    isNumber: true,
                    number: "test@gmail.com"),
                                      Stack(children: [
                  const FieldsBackground(),
                  Form(
                      key: otpCtrl.otpKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ContainerWithTextLayout(
                                title:
                                    language(context, appFonts.enterOtp)),
                            const VSpace(Sizes.s8),
                            const CommonOtpLayout(),
                            const VSpace(Sizes.s20),
                            ButtonCommon(
                                title: appFonts.verifyProceed,
                                margin: Insets.i20,
                                onTap: () => route.pushNamed(
                                    context, routeName.resetPass)),
                            const VSpace(Sizes.s15),
                            otpCtrl.isCountDown
                                ? Text("${otpCtrl.min} : ${otpCtrl.sec}",
                                        style: appCss.dmDenseMedium14
                                            .textColor(appColor(context)
                                                .appTheme
                                                .primary))
                                    .alignment(Alignment.center)
                                : Text(
                                        language(
                                            context, appFonts.resendCode),
                                        style: appCss.dmDenseMedium14
                                            .textColor(appColor(context)
                                                .appTheme
                                                .primary))
                                    .inkWell(onTap: () {})
                                    .alignment(Alignment.center)
                          ]).paddingSymmetric(vertical: Insets.i20))
                                      ]).paddingSymmetric(horizontal: Insets.i20)
                                    ])))));
    });
  }
}
