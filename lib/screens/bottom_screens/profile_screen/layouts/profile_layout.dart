import '../../../../config.dart';

class ProfileLayout extends StatelessWidget {
  final GestureTapCallback? onTap;

  const ProfileLayout({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(builder: (contextTheme, theme, child) {
      return Consumer<ProfileProvider>(
          builder: (context, profileProvider, child) {
        final user = profileProvider.user;
        final isLoading = profileProvider.isLoading;

        return Stack(alignment: Alignment.topRight, children: [
          SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(children: [
                    if (isLoading)
                      const CircularProgressIndicator()
                    else if (user != null)
                      ProfilePicCommon(
                          imageUrl: user.profilePictureUrl, isProfile: true),
                    const VSpace(Sizes.s5),
                    if (isLoading)
                      const CircularProgressIndicator()
                    else if (user != null)
                      Text("${user.firstname} ${user.lastname}",
                          style: appCss.dmDenseSemiBold14
                              .textColor(appColor(context).appTheme.darkText)),
                    const VSpace(Sizes.s3),
                    if (user != null)
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(user.email.isNotEmpty
                                ? eSvgAssets.email
                                : eSvgAssets.phone),
                            const HSpace(Sizes.s5),
                            Text(
                                user.email.isNotEmpty
                                    ? user.email
                                    : user.phoneNumber ?? "",
                                style: appCss.dmDenseMedium12.textColor(
                                    appColor(context).appTheme.lightText))
                          ]),
                  ]).paddingSymmetric(
                      vertical: Insets.i15, horizontal: Insets.i13))
              .boxShapeExtension(
                  color: appColor(contextTheme).appTheme.fieldCardBg,
                  radius: AppRadius.r12),
          SvgPicture.asset(eSvgAssets.edit)
              .paddingAll(Insets.i15)
              .inkWell(onTap: onTap)
        ]);
      });
    });
  }
}
