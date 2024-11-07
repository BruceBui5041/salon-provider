import 'package:flutter/cupertino.dart';
import '../../config.dart';

class ChangePasswordProvider extends ChangeNotifier {
  TextEditingController txtOldPassword = TextEditingController();
  TextEditingController txtNewPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();
  GlobalKey<FormState> resetFormKey = GlobalKey<FormState>();
  bool isNewPassword = true, isConfirmPassword = true,isOldPassword =true;

  final FocusNode oldPasswordFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();

  double slider = 4.0;

  //old password see tap
  oldPasswordSeenTap() {
    isOldPassword = !isOldPassword;
    notifyListeners();
  }

  //new password see tap
  newPasswordSeenTap() {
    isNewPassword = !isNewPassword;
    notifyListeners();
  }

  //confirm password see tap
  confirmPasswordSeenTap() {
    isConfirmPassword = !isConfirmPassword;
    notifyListeners();
  }

  updatePassword(context) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (resetFormKey.currentState!.validate()) {
      showCupertinoDialog(
        barrierDismissible: true,
        context: context,
        builder: (context1) {
          return AlertDialogCommon(
            title: appFonts.successfullyChanged,
            height: Sizes.s140,
            image: eGifAssets.successGif,
            subtext: language(context, appFonts.thankYou),
            bText1: language(context, appFonts.loginAgain),
            b1OnTap: () {
              txtNewPassword.text = "";
              txtOldPassword.text = "";
              txtConfirmPassword.text = "";
              notifyListeners();
             route.pushNamedAndRemoveUntil(context, routeName.loginServiceman);
            },
          );
        },
      );
    }



  }


}
