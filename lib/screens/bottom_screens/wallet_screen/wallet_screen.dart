import '../../../config.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<WalletProvider,HomeProvider>(builder: (context, value,homeVal, child) {
      return StatefulWrapper(
          onInit: () => Future.delayed(
              const Duration(milliseconds: 50), () => value.onReady()),
          child: Scaffold(
              appBar: AppBar(
                  leadingWidth: 0,
                  centerTitle: false,
                  title: Text(language(context, appFonts.wallet),
                      style: appCss.dmDenseBold18
                          .textColor(appColor(context).appTheme.darkText)),
                  actions: [
                    CommonArrow(arrow: eSvgAssets.add,onTap: ()=> value.onTapAdd(context)),
                    CommonArrow(
                            arrow: eSvgAssets.notification,
                            onTap: () => route.pushNamed(
                                context, routeName.notification))
                        .paddingSymmetric(horizontal: Insets.i20)
                  ]),
              body: SingleChildScrollView(
                  child: Column(children: [
                 WalletBalanceLayout(onTap: ()=> homeVal.onWithdraw(context)),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(language(context, appFonts.paymentHistory),
                          style: appCss.dmDenseBold18
                              .textColor(appColor(context).appTheme.darkText))
                      .paddingOnly(top: Insets.i20, bottom: Insets.i15),
                  ...value.paymentHistoryList
                      .asMap()
                      .entries
                      .map((e) => PaymentHistoryLayout(data: e.value,onTap: ()=> route.pushNamed(context, routeName.bookingDetails)))
                ]).paddingSymmetric(horizontal: Insets.i20)
              ]).paddingOnly(bottom: Insets.i100))));
    });
  }
}
