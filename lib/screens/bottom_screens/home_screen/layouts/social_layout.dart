import '../../../../config.dart';

class SocialLayout extends StatelessWidget {
  final dynamic data;
  final List? list;
  final int? index;
  final GestureTapCallback? onTap;
  const SocialLayout({super.key,this.list,this.index,this.data,this.onTap});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          SizedBox(
              height: Sizes.s15,
              width: Sizes.s15,
              child: SvgPicture.asset(data,colorFilter: ColorFilter.mode(appColor(context).appTheme.darkText, BlendMode.srcIn))),
          if(index != list!.length -1)
          VerticalDivider(width: 1,color: appColor(context).appTheme.primary.withOpacity(0.3),thickness: 1).paddingSymmetric(horizontal: Insets.i14)
        ]
      ).inkWell(onTap: onTap)
    );
  }
}
