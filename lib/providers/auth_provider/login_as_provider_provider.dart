import 'package:cookie_jar/cookie_jar.dart';
import 'package:salon_provider/config.dart';
import 'package:salon_provider/config/auth_config.dart';
import 'package:salon_provider/config/cookie_config.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/config/storage_config.dart';
import 'package:salon_provider/helper/notification_helper.dart';
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
      if (response != null) {
        if (response.data?.challenge == "otp") {
          await repo.resendOtp(context);
          route.pushNamed(context, routeName.verifyOtp);
        } else {
          var userId = response.data?.user.id;

          await AuthConfig.setUserId(userId ?? "");

          // pref!.setString("token", response.data!.token!);
          // pref!.setString("user_id", response.data!.id!);
          // pref!.setString("user_name", response.data!.name!);
          // pref!.setString("user_email", response.data!.email!);
          // pref!.setString("user_phone", response.data!.phone!);
          // pref!.setString("user_image", response.data!.image!);
          // pref!.setString("user_address", response.data!.address!);
          // pref!.setString("user_lat", response.data!.lat!);
          // pref!.setString("user_lng", response.data!.lng!);
          // pref!.setString("user_city", response.data!.city!);
          // pref!.setString("user_country", response.data!.country!);
          // pref!.setString("user_zip", response.data!.zip!);
          // pref!.setString("user_status", response.data!.status!);
          // pref!.setString("user_type", response.data!.type!);
          // pref!.setString("user_created_at", response.data!.createdAt!);
          // pref!.setString("user_updated_at", response.data!.updatedAt!);
          // pref!.setString("user_deleted_at", response.data!.deletedAt!);
          route.pushNamed(context, routeName.dashboard);
        }
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     content: Text(response.message!),
        //     backgroundColor: appColor(context).appTheme.error));
      }
    }
  }

  Future<void> logoutUser() async {
    var res = await repo.logoutUser();
    if (res.data == true) {
      await StorageConfig.deleteAll();
    }
  }

  Future<void> checkAuth(BuildContext context) async {
    var res = await repo.checkAuth();
    List<String> cookiesList = await StorageConfig.readList();
    if (cookiesList.isEmpty) {
      await StorageConfig.deleteAll();
      return;
    }

    if (res != null) {
      await AuthConfig.setUserId(res.data.id);
      route.pushNamed(context, routeName.dashboard);
    }
  }
}
