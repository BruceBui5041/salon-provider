import 'package:salon_provider/config.dart';
import 'package:salon_provider/model/response/service_response.dart';
import 'package:salon_provider/providers/app_pages_provider/all_service_provider.dart';
import 'package:salon_provider/providers/app_pages_provider/edit_service_provider.dart';
import 'package:salon_provider/widgets/cache_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeaturedServicesLayout extends StatefulWidget {
  final int? limit;
  const FeaturedServicesLayout({super.key, this.limit});

  @override
  State<FeaturedServicesLayout> createState() => _FeaturedServicesLayoutState();
}

class _FeaturedServicesLayoutState extends State<FeaturedServicesLayout> {
  final ScrollController _scrollController = ScrollController();
  static const int _pageSize = 5;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _isInitialized = true;
      // Initial load of first page
      _loadInitialPage();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadInitialPage() async {
    final provider = Provider.of<AllServiceProvider>(context, listen: false);
    await provider.fetchPage(0, limit: _pageSize, orderBy: "id desc");
  }

  void _onScroll() {
    final provider = Provider.of<AllServiceProvider>(context, listen: false);
    if (provider.isLoading || !provider.hasMoreData) return;

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadNextPage();
    }
  }

  Future<void> _loadNextPage() async {
    final provider = Provider.of<AllServiceProvider>(context, listen: false);
    await provider.fetchPage(provider.currentOffset,
        limit: _pageSize, orderBy: "id desc");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AllServiceProvider>(builder: (context, provider, _) {
      if (provider.serviceResponse.isEmpty && !provider.isLoading) {
        return const SizedBox(
          height: 200,
          child: Center(
            child: Text('No services found'),
          ),
        );
      }

      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              itemCount: provider.serviceResponse.length +
                  (provider.hasMoreData ? 1 : 0),
              itemBuilder: (context, index) {
                // If we're at the end and have more data, show a loading indicator
                if (index == provider.serviceResponse.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                // Otherwise, show a service item
                final service = provider.serviceResponse[index];
                return GestureDetector(
                  onTap: () {
                    route.pushNamed(
                      context,
                      routeName.customServiceDetails,
                      arg: service,
                    );
                  },
                  child: _serviceItem(context, service, index),
                );
              },
            ),
            // Show a loading indicator when loading the first page
            if (provider.isLoading && provider.serviceResponse.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      );
    });
  }

  Widget _serviceItem(BuildContext context, Service value, int index) {
    return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              Stack(
                children: [
                  SizedBox(
                    height: Sizes.s150,
                    width: MediaQuery.of(context).size.width,
                    child: CacheImageWidget(
                      url: value.imageResponse?[0].url ?? '',
                    ),
                  ),
                  Positioned(
                    top: Insets.i10,
                    right: Insets.i10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: appColor(context).appTheme.whiteBg,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: appColor(context)
                                .appTheme
                                .darkText
                                .withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(Icons.visibility_outlined,
                            color: appColor(context).appTheme.primary,
                            size: Sizes.s20),
                        onPressed: () {
                          Provider.of<EditServiceProvider>(context,
                                  listen: false)
                              .passData(value, callback: () {
                            route.pushNamed(
                              context,
                              routeName.customServiceDetails,
                              arg: value,
                            );
                          });
                        },
                        padding: const EdgeInsets.all(Insets.i8),
                        constraints: const BoxConstraints(),
                      ),
                    ),
                  ),
                ],
              ),
              const VSpace(Sizes.s12),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BookingStatusLayout(
                              title: value.status,
                              color: value.status?.toLowerCase() == "active"
                                  ? appColor(context).appTheme.online
                                  : value.status?.toLowerCase() == "inactive"
                                      ? appColor(context).appTheme.red
                                      : appColor(context).appTheme.yellow),
                          Text(
                              language(context,
                                  value.serviceVersion?.title ?? 'Unknown'),
                              style: appCss.dmDenseSemiBold15.textColor(
                                  appColor(context).appTheme.darkText)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            value.serviceVersion?.price?.toCurrencyVnd() ?? '',
                            style: appCss.dmDenseMedium14
                                .textColor(appColor(context).appTheme.lightText)
                                .copyWith(
                                    decoration: TextDecoration.lineThrough),
                          ),
                          Text(
                            value.serviceVersion?.discountedPrice
                                    ?.toCurrencyVnd() ??
                                '',
                            style: appCss.dmDenseBold16
                                .textColor(appColor(context).appTheme.darkText),
                          ),
                        ],
                      ),
                    ]),
              ])
            ]))
        .paddingAll(Insets.i15)
        .boxBorderExtension(context,
            isShadow: true, bColor: appColor(context).appTheme.stroke)
        .inkWell(onTap: () {
      route.pushNamed(context, routeName.customServiceDetails, arg: value);
    }).paddingOnly(bottom: Insets.i15);
  }
}
