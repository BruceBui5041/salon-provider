import 'dart:async';
import 'package:fixit_provider/config/injection_config.dart';
import 'package:fixit_provider/screens/auth_screens/verify_otp_screen/repository/verify_otp_repository.dart';

import '../../config.dart';

class VerifyOtpProvider with ChangeNotifier {
  var repo = getIt<VerifyOtpRepository>();
  TextEditingController otpController = TextEditingController();
  GlobalKey<FormState> otpKey = GlobalKey<FormState>();

  String? phone, dialCode, verificationCode, min, sec, email;
  bool isCodeSent = false, isCountDown = false, isEmail = false;
  Timer? countdownTimer;
  final FocusNode phoneFocus = FocusNode();
  Duration myDuration = const Duration(seconds: 60);

  Future<void> verifyOtp({Function()? onSucess}) async {
    String otp = otpController.text;
    try {
      await repo.verifyOtp({"otp": otp});
      if (onSucess != null) {
        onSucess();
      }
    } catch (e) {
      print(e);
    }
  }

  defaultTheme(context) {
    final defaultPinTheme = PinTheme(
        textStyle: appCss.dmDenseSemiBold18
            .textColor(appColor(context).appTheme.darkText),
        width: Sizes.s55,
        height: Sizes.s48,
        decoration: BoxDecoration(
            color: appColor(context).appTheme.whiteBg,
            borderRadius: BorderRadius.circular(AppRadius.r8),
            border: Border.all(color: appColor(context).appTheme.whiteBg)));
    return defaultPinTheme;
  }
}
