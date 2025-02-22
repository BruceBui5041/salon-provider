import 'dart:math';

import '../../../../config.dart';

class AddServicemenProfileLayout extends StatelessWidget {
  const AddServicemenProfileLayout({super.key});

  @override
  Widget build(BuildContext context) {

    final value = Provider.of<AddServicemenProvider>(context);

    return Stack(alignment: Alignment.center, children: [
      Image.asset(eImageAssets.servicemanBg,
          height: Sizes.s66,
          width: MediaQuery.of(context).size.width)
          .paddingOnly(
          bottom: Insets.i45,
          right: Insets.i20,
          left: Insets.i20),
      Stack(alignment: Alignment.bottomRight, children: [
        value.profileFile != null
            ? const ServicemenProfileLayout(isFilePath: true)
            : value.userName.text.isNotEmpty
            ? ServicemenProfileLayout(
            isFilePath: false,
            color:
            value.colorCollection[Random().nextInt(9)],
            child: Text(value.userName.text[0],
                textAlign: TextAlign.center,
                style: appCss.dmDenseMedium44.textColor(
                    appColor(context).appTheme.whiteBg)))
            : ServicemenProfileLayout(
            isFilePath: false,
            child: Image.asset(eImageAssets.user,
                width: Sizes.s50, height: Sizes.s50)),
        SizedBox(
            child: SvgPicture.asset(
                value.profileFile != null
                    ? eSvgAssets.edit
                    : eSvgAssets.camera,
                height: Sizes.s14)
                .paddingAll(Insets.i7))
            .inkWell(onTap: () => value.onImagePick(context, true))
            .decorated(
            color: appColor(context).appTheme.stroke,
            shape: BoxShape.circle,
            border: Border.all(
                color: appColor(context).appTheme.primary))
      ])
    ]);
  }
}
