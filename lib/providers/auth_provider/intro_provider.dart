import 'package:salon_provider/config.dart';
import 'package:salon_provider/config/constant_api_config.dart';
import 'package:salon_provider/config/cookie_config.dart';

class IntroProvider with ChangeNotifier {
  int selectedIndex = 0;

  onTapOption(index) {
    selectedIndex = index;
    notifyListeners();
  }

  onContinue(context) async {
    if (selectedIndex == 0) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      isFreelancer = false;
      prefs.setBool("isFreelancer", isFreelancer);
      route.pushNamed(context, routeName.registerScreen);
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      isFreelancer = true;
      prefs.setBool("isFreelancer", isFreelancer);
      route.pushNamed(context, routeName.registerScreen);
      notifyListeners();
    }
  }

  onSignUp(context) {
    showDialog(
        context: context,
        builder: (context1) {
          return StatefulBuilder(builder: (context2, setState) {
            return Consumer<IntroProvider>(builder: (context, value, child) {
              return AlertDialogCommon(
                  isBooked: true,
                  title: appFonts.selectOption,
                  widget: Column(children: [
                    Text(language(context, appFonts.toCreateAnew),
                        style: appCss.dmDenseMedium13
                            .textColor(appColor(context).appTheme.lightText)),
                    const VSpace(Sizes.s15),
                    Text(language(context, appFonts.iAmJoining),
                            style: appCss.dmDenseMedium14
                                .textColor(appColor(context).appTheme.primary))
                        .alignment(Alignment.centerLeft),
                    const VSpace(Sizes.s35),
                    Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: appArray.joiningList
                                .asMap()
                                .entries
                                .map((e) => JoiningLayout(
                                    data: e.value,
                                    index: e.key,
                                    selectedIndex: selectedIndex,
                                    onTap: () => onTapOption(e.key)))
                                .toList())
                        .paddingSymmetric(horizontal: Insets.i10)
                  ]),
                  subtext: "",
                  bText1: appFonts.continues,
                  b1OnTap: () => onContinue(context));
            });
          });
        });
  }

  Future<void> checkCookie(BuildContext context,
      {Function()? onSuccess}) async {
    await CookieConfig.setCookieToApi(Uri.parse(ConstantApiConfig().getUrl));
    Provider.of<LoginAsProvider>(context, listen: false).checkAuth(
        onSuccess: () {
      if (onSuccess != null) {
        onSuccess();
      }
    });
    notifyListeners();
  }
}
