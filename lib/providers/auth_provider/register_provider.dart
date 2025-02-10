import 'package:fixit_provider/config.dart';
import 'package:fixit_provider/config/injection_config.dart';
import 'package:fixit_provider/screens/auth_screens/register_screen/repository/register_repository.dart';

class RegisterProvider extends ChangeNotifier {
  var repo = getIt<RegisterRepository>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();

  Future<void> onRegister(BuildContext context) async {
    final requestBody = {
      "firstname": firstNameController.text,
      "lastname": lastNameController.text,
      "auth_type": "phone_number",
      "phone_number": phoneController.text,
    };
    final response = await repo.registerUser(requestBody);
    if (response != null) {
      route.pushNamed(context, routeName.verifyOtp);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response.message!),
      ));
    }
  }
}
