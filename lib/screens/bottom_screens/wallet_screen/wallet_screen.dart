import '../../../config.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      Provider.of<WalletProvider>(context, listen: false).loadMorePayments();
    }
  }

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
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(children: [
                        WalletBalanceLayout(
                            onTap: () => homeVal.onWithdraw(context)),
                        if (value.error != null)
                          Text(value.error!,
                                  style: appCss.dmDenseRegular14.textColor(
                                      appColor(context).appTheme.red))
                              .paddingSymmetric(vertical: Insets.i20),
                        if (value.isLoading && value.paymentList.isEmpty)
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
                                  Column(
                                    children: [
                                      ...value.paymentList.map(
                                          (payment) => PaymentHistoryLayout(
                                              data: payment,
                                              onTap: () {
                                                if (payment.booking?.id !=
                                                    null) {
                                                  route.pushNamed(context,
                                                      routeName.bookingDetails,
                                                      arg: payment.booking!.id);
                                                }
                                              })),
                                      if (value.isLoadingMore)
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 16.0),
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                    ],
                                  ),
                              ]).paddingSymmetric(horizontal: Insets.i20)
                      ]).paddingOnly(bottom: Insets.i100)))));
    });
  }
}
