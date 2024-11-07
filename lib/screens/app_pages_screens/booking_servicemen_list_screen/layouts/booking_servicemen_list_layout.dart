import '../../../../config.dart';

class BookingServicemenListLayout extends StatelessWidget {
  final dynamic data;
  final List? selList;
  final int? index,list,selectedIndex;
  final GestureTapCallback? onTap,onTapRadio;
  const BookingServicemenListLayout({super.key, this.data, this.selList, this.index, this.onTap, this.list, this.selectedIndex, this.onTapRadio});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.zero,
        dense: true,
        leading: Container(
          height: Sizes.s40,
          width: Sizes.s40,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                  image: AssetImage(data["image"]))),
        ),
        title: IntrinsicHeight(
          child: Row(children: [
            Text(language(context, data["title"]),
                style: appCss.dmDenseMedium14
                    .textColor(appColor(context).appTheme.darkText)),
            VerticalDivider(
                width: 1,
                thickness: 1,
                color: appColor(context).appTheme.stroke,
                indent: 6,
                endIndent: 6).paddingSymmetric(horizontal: Insets.i6),
            Row(children: [
              SvgPicture.asset(eSvgAssets.star),
              const HSpace(Sizes.s4),
              Text(data["rate"],
                  style: appCss.dmDenseMedium13
                      .textColor(appColor(context).appTheme.darkText))
            ])
          ]),
        ),
        subtitle: Text(language(context, "${language(context, appFonts.memberSince)} ${data["year"]}"),
            style: appCss.dmDenseMedium12
                .textColor(appColor(context).appTheme.lightText)),
        trailing: list! <= 1 ? CommonRadio(selectedIndex: selectedIndex,index: index,onTap: onTapRadio,).inkWell(onTap: onTap) :  Container(
            height: Sizes.s20,
            width: Sizes.s20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: selList!.contains(index)
                    ? appColor(context).appTheme.primary
                    : appColor(context).appTheme.whiteBg,
                borderRadius: BorderRadius.circular(AppRadius.r4),
                border: Border.all(color:selList!.contains(index)
                    ? appColor(context).appTheme.trans
                    : appColor(context).appTheme.stroke)),
            child: selList!.contains(index)
                ? Icon(Icons.check,
                size: Sizes.s15,
                color: appColor(context).appTheme.whiteBg)
                : null)
            .inkWell(onTap: onTap) )
        .paddingSymmetric(horizontal: Insets.i15)
        .boxBorderExtension(context,color: appColor(context).appTheme.whiteBg,isShadow: true,radius: AppRadius.r10).paddingOnly(bottom: Insets.i15);
  }
}
