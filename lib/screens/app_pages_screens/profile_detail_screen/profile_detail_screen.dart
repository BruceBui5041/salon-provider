import '../../../config.dart';


class ProfileDetailScreen extends StatelessWidget {
  const ProfileDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileDetailProvider>(builder: (context1, value, child) {
      return Scaffold(
          appBar: AppBar(
              centerTitle: true,
              leading: CommonArrow(
                  arrow: rtl(context) ? eSvgAssets.arrowRight : eSvgAssets.arrowLeft,
                  onTap: () => route.pop(context)).paddingAll(Insets.i8),
              title: Text(language(context, appFonts.profileDetails),
                  style: appCss.dmDenseBold18
                      .textColor(appColor(context).appTheme.darkText))),
          body: SingleChildScrollView(
              child: Column(children: [
            const VSpace(Sizes.s20),
            Stack(children: [
              const FieldsBackground(),
              Column(children: [
                Stack(alignment: Alignment.bottomCenter, children: [
                  Image.asset(eImageAssets.servicemanBg,
                          width: MediaQuery.of(context).size.width,
                          height: Sizes.s60)
                      .paddingOnly(bottom: Insets.i45),
                  Stack(alignment: Alignment.bottomRight, children: [
                    ProfilePicCommon(

                        image: value.imageFile,
                        imageUrl:/* value.userModel != null
                            ? value.userModel!.media![0].originalUrl != null
                                ? value.userModel!.media![0].originalUrl!
                                : null
                            :*/ null),
                    SizedBox(
                            child: SvgPicture.asset(eSvgAssets.edit,
                                    height: Sizes.s14)
                                .paddingAll(Insets.i7))
                        .decorated(
                            color: appColor(context).appTheme.stroke,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: appColor(context).appTheme.primary))
                        .inkWell(onTap: () => value.showLayout(context))
                  ])
                ]),
                const VSpace(Sizes.s40),
                TextFieldLayout(value: value)
              ]).paddingSymmetric(vertical: Insets.i20)
            ]),
            const VSpace(Sizes.s40),
            ButtonCommon(title: appFonts.update,onTap: ()=> value.onUpdate(context))
          ]).paddingSymmetric(horizontal: Insets.i20)));
    });
  }
}
