import '../../../config.dart';

class SignUpCompanyScreen extends StatefulWidget {
  const SignUpCompanyScreen({super.key});

  @override
  State<SignUpCompanyScreen> createState() => _SignUpCompanyScreenState();
}

class _SignUpCompanyScreenState extends State<SignUpCompanyScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context1) {
    return Consumer<SignUpCompanyProvider>(builder: (context, value, child) {
      return StatefulWrapper(
        onInit: ()=> Future.delayed(const Duration(milliseconds: 50),()=> value.onReady()),
        child: PopScope(
          canPop: false,
          onPopInvoked: (bool didPop)=> value.popInvoke (didPop),
          child: Scaffold(
              appBar: AppBarCommon(title: appFonts.signUp),
              body: SingleChildScrollView(
                controller: value.controller,
                  child: Column(children: [
                Stack(
                  alignment: rtl(context) ? Alignment.centerLeft : Alignment.centerRight,
                  children: [
                    LinearPercentIndicator(
                        animation: true,
                        padding: const EdgeInsets.symmetric(horizontal: Insets.i20),
                        width: MediaQuery.of(context).size.width,
                        lineHeight: Sizes.s46,
                        barRadius: const Radius.circular(AppRadius.r8),
                        percent: isFreelancer
                            ? value.pageIndex == 2
                                ? 0.50
                                : 1
                            : value.pageIndex == 0
                                ? 0.35
                                : value.pageIndex == 1
                                    ? 0.70
                                    : 1,
                        backgroundColor:
                            appColor(context).appTheme.primary.withOpacity(0.2),
                        progressColor: appColor(context).appTheme.primary,
                        center: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(language(context, appFonts.fewMoreSteps),
                                  style: appCss.dmDenseMedium14
                                      .textColor(appColor(context).appTheme.whiteBg)),
                            ]).paddingSymmetric(horizontal: Insets.i15)),
                    Image.asset(eGifAssets.coin,height: Sizes.s26,width: Sizes.s26).paddingSymmetric(horizontal: Insets.i35)
                  ],
                ),
                const VSpace(Sizes.s15),
                Stack(children: [
                  const FieldsBackground(),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                            language(
                                    context,
                                    value.pageIndex == 0
                                        ? appFonts.companyDetails
                                        : value.pageIndex == 1
                                            ? appFonts.companyLocation
                                            : appFonts.providerDetails)
                                .toUpperCase(),
                            style: appCss.dmDenseMedium16
                                .textColor(appColor(context).appTheme.darkText)),
                        const DottedLines().paddingSymmetric(vertical: Insets.i20),
                        value.pageIndex == 0
                            ? SignUpOne()
                            : value.pageIndex == 1
                                ? SignUpTwo(sync: this)
                                : SignUpThree()
                      ]).paddingSymmetric(vertical: Insets.i20)
                ]).paddingSymmetric(horizontal: Insets.i20),
                ButtonCommon(
                        title: value.pageIndex == 0 || value.pageIndex == 1
                            ? appFonts.next
                            :  appFonts.finish,
                        onTap:  () => value.onNext(context))
                    .paddingSymmetric(horizontal: Insets.i20, vertical: Insets.i20)
              ])))
        )
      );
    });
  }
}
