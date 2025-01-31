import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import '../../config.dart';

class ResetPasswordProvider extends ChangeNotifier {
  TextEditingController txtNewPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();
  GlobalKey<FormState> resetFormKey = GlobalKey<FormState>();
  bool isNewPassword = true, isConfirmPassword = true;
  String? email, otp;
  Future<ui.Image>? loadingImage;
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();

  double slider = 4.0;

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

  static getDisposableProviders(BuildContext context) {
    return [
      Provider.of<LoginAsProvider>(context, listen: false),
      //...other disposable providers
    ];
  }

  static void disposeAllDisposableProviders(BuildContext context) {
    getDisposableProviders(context).forEach((disposableProvider) {
      disposableProvider.dispose();
    });
  }

  /*getArg(context) {
    dynamic data = ModalRoute.of(context)!.settings.arguments;
    email = data['email'];
    otp = data['otp'];
    notifyListeners();
  }*/

  Future<ui.Image> loadImage(String assetPath) async {
    ByteData data = await rootBundle.load(assetPath);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }
}
