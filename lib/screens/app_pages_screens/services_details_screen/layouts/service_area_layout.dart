import '../../../../config.dart';

class ServiceAreaLayout extends StatefulWidget {
  final GestureTapCallback? onTapAdd;

  const ServiceAreaLayout(
      {super.key,this.onTapAdd});

  @override
  State<ServiceAreaLayout> createState() => _ServiceAreaLayoutState();
}

class _ServiceAreaLayoutState extends State<ServiceAreaLayout> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer<LocationListProvider>(
      builder: (context,value,child) {
        return Column(
          children: [
            Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(language(context, appFonts.serviceAvailableArea), style: appCss.dmDenseRegular14
                            .textColor(appColor(context).appTheme.lightText)),
                        Text(language(context, "+${language(context, appFonts.add)}"), style: appCss.dmDenseMedium14
                            .textColor(appColor(context).appTheme.primary)).inkWell(onTap: widget.onTapAdd)
                      ]
                  ).paddingSymmetric(vertical: Insets.i10),
                  ...value.addedLocation.asMap().entries.map((e) => ServicemanListLayout(
                      isDetail: true,
                      onDelete: ()=> value.onTapDetailLocationDelete(e.key,context,this),
                      data: e.value,
                      index: e.key,
                      list: value.addedLocation
                  )).toList()
                ]
            )
          ]
        );
      }
    );
  }
}
