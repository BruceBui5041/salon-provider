import 'package:salon_provider/config.dart';

class ForgetPasswordProvider with ChangeNotifier {
  TextEditingController forgetController = TextEditingController();
  GlobalKey<FormState> forgetKey = GlobalKey<FormState>();
  final FocusNode emailFocus = FocusNode();
}
