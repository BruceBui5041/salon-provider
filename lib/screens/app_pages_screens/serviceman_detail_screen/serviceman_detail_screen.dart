import '../../../config.dart';

class ServicemanDetailScreen extends StatefulWidget {
  const ServicemanDetailScreen({super.key});

  @override
  State<ServicemanDetailScreen> createState() => _ServicemanDetailScreenState();
}

class _ServicemanDetailScreenState extends State<ServicemanDetailScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer<ServicemenDetailProvider>(
      builder: (context,value,child) {
        return StatefulWrapper(
          onInit: ()=> Future.delayed(const Duration(milliseconds: 20), ()=> value.onReady(context)),
          child: Scaffold(
              appBar: AppBar(
                  leadingWidth: 80,
                  title: Text(language(context, appFonts.servicemanDetail),
                      style: appCss.dmDenseBold18
                          .textColor(appColor(context).appTheme.darkText)),
                  centerTitle: true,
                  leading: CommonArrow(
                      arrow:
                      rtl(context) ? eSvgAssets.arrowRight : eSvgAssets.arrowLeft,
                      onTap: () => route.pop(context)).paddingAll(Insets.i8),
                  actions: [
                    if(value.isIcons)
                    CommonArrow(
                            arrow: eSvgAssets.delete,
                            svgColor: appColor(context).appTheme.red,
                            color: appColor(context).appTheme.red.withOpacity(0.1),
                            onTap: ()=> value.onServicemenDelete(context,this))
                        .paddingSymmetric(horizontal: Insets.i20)
                  ]),
              body: SingleChildScrollView(
                  child: Column(children: [
                const Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  ServicemenDetailProfileLayout(),
                  VSpace(Sizes.s20),
                  PersonalInfoLayout()
                ])
                    .paddingAll(Insets.i15)
                    .boxBorderExtension(context,isShadow: true)
                    .paddingSymmetric(horizontal: Insets.i20, vertical: Insets.i2)
              ]).paddingSymmetric(vertical: Insets.i15))),
        );
      }
    );
  }
}
