import 'package:salon_provider/config.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/model/response/role_response.dart';
import 'package:salon_provider/repositories/login_repository.dart';

class LoginAsServicemanProvider with ChangeNotifier {
  var repo = getIt<LoginScreenRepository>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> servicemenKey =
      GlobalKey<FormState>(debugLabel: 'servicemenKey');
  SharedPreferences? pref;
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();

  void onLogin(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final response = await repo.loginUser(phoneController.text);
      if (response.errorKey != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response.message!,
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.black87,
          ),
        );
        return;
      }

      if (!response.data!.user.roles
          .any((element) => element.code == UserRoleCode.provider)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              language(context, appFonts.notProvider),
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.black87,
          ),
        );
        return;
      }

      pref = await SharedPreferences.getInstance();
      route.pushNamed(context, routeName.dashboard);
    }
  }
}
