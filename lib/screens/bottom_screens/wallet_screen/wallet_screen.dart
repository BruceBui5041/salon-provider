import '../../../config.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<WalletProvider, HomeProvider>(
        builder: (context, value, homeVal, child) {
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
                    Stack(
                      children: [
                        CommonArrow(
                          arrow: eSvgAssets.filter,
                          onTap: () => value.onTapFilter(context),
                          color: value.hasActiveFilters
                              ? appColor(context).appTheme.primary
                              : appColor(context).appTheme.fieldCardBg,
                          svgColor: value.hasActiveFilters
                              ? appColor(context).appTheme.whiteColor
                              : appColor(context).appTheme.darkText,
                        ),
                        if (value.hasActiveFilters)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: Sizes.s10,
                              height: Sizes.s10,
                              decoration: BoxDecoration(
                                color: appColor(context).appTheme.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                      ],
                    ),
                    CommonArrow(
                            arrow: eSvgAssets.notification,
                            onTap: () => route.pushNamed(
                                context, routeName.notification))
                        .paddingSymmetric(horizontal: Insets.i20)
                  ]),
              body: RefreshIndicator(
                  onRefresh: () => value.fetchPayments(),
                  child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(children: [
                        WalletBalanceLayout(
                            onTap: () => homeVal.onWithdraw(context)),
                        if (value.error != null)
                          Text(value.error!,
                                  style: appCss.dmDenseRegular14.textColor(
                                      appColor(context).appTheme.red))
                              .paddingSymmetric(vertical: Insets.i20),
                        if (value.isLoading)
                          const CircularProgressIndicator()
                              .paddingSymmetric(vertical: Insets.i20)
                        else
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(language(context, appFonts.paymentHistory),
                                        style: appCss.dmDenseBold18.textColor(
                                            appColor(context)
                                                .appTheme
                                                .darkText))
                                    .paddingOnly(
                                        top: Insets.i20, bottom: Insets.i15),
                                if (value.paymentList.isEmpty)
                                  Center(
                                          child: Text(
                                              language(context,
                                                  appFonts.ohhNoListEmpty),
                                              style: appCss.dmDenseRegular14
                                                  .textColor(appColor(context)
                                                      .appTheme
                                                      .lightText)))
                                      .paddingSymmetric(vertical: Insets.i20)
                                else
                                  ...value.paymentList
                                      .map((payment) => PaymentHistoryLayout(
                                          data: payment,
                                          onTap: () {
                                            if (payment.booking?.id != null) {
                                              route.pushNamed(context,
                                                  routeName.bookingDetails,
                                                  arg: payment.booking!.id);
                                            }
                                          }))
                              ]).paddingSymmetric(horizontal: Insets.i20)
                      ]).paddingOnly(bottom: Insets.i100)))));
    });
  }
}
