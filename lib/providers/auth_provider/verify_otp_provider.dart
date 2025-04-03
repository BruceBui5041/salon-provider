import 'dart:async';
import 'package:salon_provider/common/Utils.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/helper/notification_helper.dart';
import 'package:salon_provider/repositories/verify_otp_repository.dart';

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
      NotificationHelper().getToken(onSuccess: (token) async {
        Utils.debug('FCM Token: $token');
        await repo.saveUserDevice(token);
      });
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
