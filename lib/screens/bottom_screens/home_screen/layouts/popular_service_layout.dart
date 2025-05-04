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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AllServiceProvider>(context, listen: false)
          .getAllServices(limit: widget.limit, orderBy: "id desc");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AllServiceProvider>(builder: (context, value, _) {
      return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(children: [
            _listService(value),
          ]));
    });
  }

  Widget _listService(AllServiceProvider value) {
    if (value.serviceResponse == null) {
      return const SizedBox();
    }
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: value.serviceResponse!.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                route.pushNamed(context, routeName.customServiceDetails,
                    arg: value.serviceResponse![index]);
              },
              child:
                  _serviceItem(context, value.serviceResponse![index], index));
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
