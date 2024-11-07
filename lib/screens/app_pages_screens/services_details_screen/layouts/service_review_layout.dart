import '../../../../config.dart';

class ServiceReviewLayout extends StatelessWidget {
  final dynamic data;
  final List? list;
  final int? index;
  final bool? isSetting;
  final GestureTapCallback? onTap;

  const ServiceReviewLayout({super.key, this.data, this.index, this.list,this.isSetting = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
      ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          leading: Container(
              height: Sizes.s40,
              width: Sizes.s40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage(data["image"])))),
          title: Text(data["name"],
              style: appCss.dmDenseMedium14
                  .textColor(appColor(context).appTheme.darkText)),
          subtitle: Text(data["time"],
              style: appCss.dmDenseMedium12
                  .textColor(appColor(context).appTheme.lightText)),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            SvgPicture.asset(eSvgAssets.star),
            const HSpace(Sizes.s4),
            Text(data["rate"],
                style: appCss.dmDenseMedium12
                    .textColor(appColor(context).appTheme.darkText))
          ])),
      const VSpace(Sizes.s5),
      Text(data["review"],
              style: appCss.dmDenseRegular12
                  .textColor(appColor(context).appTheme.darkText))
          .paddingOnly(bottom: Insets.i15),
              if(isSetting == true)
              ReviewBottomLayout(serviceName: data["service"],onTap: onTap)
    ]))
        .paddingSymmetric(horizontal: Insets.i15)
        .boxBorderExtension(context,bColor: appColor(context).appTheme.stroke)
        .paddingOnly(bottom: index != list!.length - 1 ? Insets.i15 : 0);
  }
}
