import '../../../config.dart';

class AppSettingScreen extends StatelessWidget {
  const AppSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppSettingProvider>(
        builder: (context1, settingCtrl, child) {
      return LoadingComponent(
          child: Scaffold(
              appBar: AppBar(
                  elevation: 0,
                  centerTitle: true,
                  leadingWidth: 80,
                  leading: CommonArrow(
                      arrow: rtl(context) ? eSvgAssets.arrowRight : eSvgAssets.arrowLeft,
                      onTap: () => route.pop(context)).paddingAll(Insets.i8),
                  title: Text(language(context, appFonts.appSetting),
                      style: appCss.dmDenseBold18
                          .textColor(appColor(context).appTheme.darkText))),
              body: const AppSettingLayout()));
    });
  }
}
