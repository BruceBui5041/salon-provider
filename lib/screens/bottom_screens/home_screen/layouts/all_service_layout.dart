import 'package:salon_provider/config.dart';
import 'package:salon_provider/model/response/service_response.dart';
import 'package:salon_provider/providers/app_pages_provider/all_service_provider.dart';
import 'package:salon_provider/providers/app_pages_provider/edit_service_provider.dart';
import 'package:salon_provider/widgets/cache_image.dart';

class AllServiceLayout extends StatefulWidget {
  const AllServiceLayout({super.key});

  @override
  State<AllServiceLayout> createState() => _AllServiceLayoutState();
}

class _AllServiceLayoutState extends State<AllServiceLayout> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AllServiceProvider>(builder: (context, value, _) {
      return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                _listService(value),
              ]))
          .paddingAll(Insets.i15)
          .boxBorderExtension(context,
              isShadow: true, bColor: appColor(context).appTheme.stroke)
          .inkWell(onTap: () {});
    });
  }

  Widget _listService(AllServiceProvider value) {
    if (value.serviceResponse == null) {
      return const SizedBox();
    }
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        // itemCount: 10/,
        itemCount: value.serviceResponse!.data.length,
        itemBuilder: (context, index) {
          return _serviceItem(
              context, value.serviceResponse!.data[index], index);
        });
  }

  Widget _serviceItem(BuildContext context, ItemService value, int index) {
    return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              SizedBox(
                height: Sizes.s150,
                width: MediaQuery.of(context).size.width,
                child: CacheImageWidget(
                  url: value.imageResponse?[0].url ?? '',
                ),
              ),
              const VSpace(Sizes.s12),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          language(context,
                              value.serviceVersion?.title ?? 'Unknown'),
                          style: appCss.dmDenseSemiBold15
                              .textColor(appColor(context).appTheme.darkText)),
                      Text(value.serviceVersion?.price?.toCurrencyVnd() ?? '',
                          style: appCss.dmDenseBold16
                              .textColor(appColor(context).appTheme.darkText))
                    ]),
                const VSpace(Sizes.s8),
                // IntrinsicHeight(
                //     child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //       Row(children: [
                //         Text("\u2022 ${value["work"]}",
                //             style: appCss.dmDenseMedium12.textColor(
                //                 appColor(context).appTheme.lightText)),
                //         VerticalDivider(
                //                 width: 1,
                //                 color: appColor(context).appTheme.stroke,
                //                 thickness: 1,
                //                 indent: 3,
                //                 endIndent: 3)
                //             .paddingSymmetric(horizontal: Insets.i6),
                //         SvgPicture.asset(eSvgAssets.receipt),
                //         const HSpace(Sizes.s5),
                //         Text(
                //             "${value["booked"]} ${language(context, appFonts.booked)}",
                //             style: appCss.dmDenseMedium12.textColor(
                //                 appColor(context).appTheme.lightText))
                //       ]),
                //       Row(children: [
                //         SvgPicture.asset(eSvgAssets.star),
                //         const HSpace(Sizes.s3),
                //         Text(value["rating"],
                //             style: appCss.dmDenseMedium13
                //                 .textColor(appColor(context).appTheme.darkText))
                //       ])
                //     ])),
                const VSpace(Sizes.s10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(language(context, appFonts.activeStatus),
                          style: appCss.dmDenseMedium12
                              .textColor(appColor(context).appTheme.darkText)),
                      Theme(
                          data: ThemeData(useMaterial3: false),
                          child: FlutterSwitchCommon(
                              value: value.status == "active",
                              onToggle: (val) {
                                //
                              }))
                    ]).paddingAll(Insets.i15).boxShapeExtension(
                    color: appColor(context).appTheme.fieldCardBg,
                    radius: AppRadius.r10)
              ]),
              const SizedBox(height: Sizes.s12),
              Row(
                children: [
                  Expanded(
                    child: ButtonCommon(
                        title: "Edit",
                        onTap: () {
                          Provider.of<EditServiceProvider>(context,
                                  listen: false)
                              .passData(value, callback: () {
                            route.pushNamed(
                              context,
                              routeName.editService,
                              arg: value,
                            );
                          });

                          // value.onEdit(context, value);
                        }),
                  ),
                ],
              )
            ]))
        .paddingAll(Insets.i15)
        .boxBorderExtension(context,
            isShadow: true, bColor: appColor(context).appTheme.stroke)
        .inkWell(onTap: () {
      //
    }).paddingOnly(bottom: Insets.i15);
  }
}
