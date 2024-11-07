import '../../../../config.dart';

class ServicemenDetailProfileLayout extends StatelessWidget {
  const ServicemenDetailProfileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<ServicemenDetailProvider>(context);
    return Column(
      children: [
        ServicemanDetailProfileLayout(image: value.imageFile,onEdit: ()=> value.onImagePick(context)),
        const VSpace(Sizes.s6),
        IntrinsicHeight(
            child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("Theodore T.C. Calvin",
                  style: appCss.dmDenseMedium14
                      .textColor(appColor(context).appTheme.darkText)),
              VerticalDivider(
                  color: appColor(context).appTheme.stroke,
                  width: 1,
                  thickness: 1,
                  indent: 5,
                  endIndent: 5)
                  .paddingSymmetric(horizontal: Insets.i6),
              SvgPicture.asset(eSvgAssets.star),
              const HSpace(Sizes.s3),
              Text("3.5",
                  style: appCss.dmDenseMedium13
                      .textColor(appColor(context).appTheme.darkText))
            ])),
        Text("${"2"} years of experience",
            style: appCss.dmDenseMedium12
                .textColor(appColor(context).appTheme.lightText)),
        const VSpace(Sizes.s10),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SvgPicture.asset(eSvgAssets.locationOut,
              colorFilter: ColorFilter.mode(
                  appColor(context).appTheme.darkText, BlendMode.srcIn)),
          const HSpace(Sizes.s5),
          Text("New jersey , USA",
              style: appCss.dmDenseMedium12
                  .textColor(appColor(context).appTheme.darkText))
        ]),
        const VSpace(Sizes.s15),
        Image.asset(eImageAssets.bulletDotted),
        const VSpace(Sizes.s15),
        ServicesDeliveredLayout(
            services: "250",
            color: appColor(context).appTheme.primary.withOpacity(0.1))
      ]
    );
  }
}
