import 'package:cookie_jar/cookie_jar.dart';
import 'package:salon_provider/config.dart';
import 'package:salon_provider/config/auth_config.dart';
import 'package:salon_provider/config/cookie_config.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/config/storage_config.dart';
import 'package:salon_provider/helper/notification_helper.dart';
import 'package:salon_provider/model/response/role_response.dart';
import 'package:salon_provider/repositories/login_repository.dart';

class LoginAsProvider with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> providerKey =
      GlobalKey<FormState>(debugLabel: 'providerKey');
  SharedPreferences? pref;
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();

  var repo = getIt<LoginScreenRepository>();

  void onLogin(BuildContext context, {Function()? onSuccess}) async {
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

      final hasProviderRole = response.data!.user.roles
              ?.any((element) => element.code == UserRoleCode.provider) ??
          false;
      if (!hasProviderRole) {
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

      if (response.data?.challenge == "otp") {
        await repo.resendOtp(context);
        route.pushNamed(context, routeName.verifyOtp);
      } else {
        var userId = response.data?.user.id;

        await AuthConfig.setUserId(userId ?? "");
        if (response.data?.user != null) {
          await AuthConfig.setUser(response.data!.user);
        }
        route.pushNamed(context, routeName.dashboard);
      }
    }
  }

  Future<void> logoutUser() async {
    var res = await repo.logoutUser();
    if (res.data == true) {
      await StorageConfig.deleteAll();
    }
  }

  Future<void> checkAuth({Function()? onSuccess}) async {
    var res = await repo.checkAuth();
    List<String> cookiesList = StorageConfig.readList();
    if (cookiesList.isEmpty) {
      await StorageConfig.deleteAll();
      return;
    }

    if (res?.id == null) throw Exception("User not found");

    await AuthConfig.setUserId(res!.id!);
    if (onSuccess != null) {
      onSuccess();
    }
  }
}
