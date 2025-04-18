import 'dart:io';

import '../../../../config.dart';

class ServicemanDetailProfileLayout extends StatelessWidget {
  final XFile? image;
  final GestureTapCallback? onEdit;
  const ServicemanDetailProfileLayout({super.key,this.image, this.onEdit});

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<ServicemenDetailProvider>(context);
    return Stack(alignment: Alignment.center, children: [
      Image.asset(eImageAssets.servicemanBg,
          height: Sizes.s66,
          width: MediaQuery.of(context).size.width)
          .paddingOnly(bottom: Insets.i40),
      Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
              alignment: Alignment.center,
              height: Sizes.s90,
              width: Sizes.s90,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: appColor(context).appTheme.whiteColor,
                      width: 4),
                  shape: BoxShape.circle,
                  image: image != null ? DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(File(image!.path))) : DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(eImageAssets.as1)) ))
              .paddingOnly(top: Insets.i12),
          if(value.isIcons)
          SizedBox(
              child: SvgPicture.asset(eSvgAssets.edit,
                  height: Sizes.s14)
                  .paddingAll(Insets.i7))
              .decorated(
              color: appColor(context).appTheme.stroke,
              shape: BoxShape.circle,
              border: Border.all(
                  color: appColor(context).appTheme.primary)).inkWell(onTap: onEdit)
        ],
      )
    ]);
  }
}
