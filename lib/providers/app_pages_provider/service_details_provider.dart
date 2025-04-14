import 'package:dio/dio.dart';
import 'package:salon_provider/common/Utils.dart';
import 'package:salon_provider/config.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/model/response/service_response.dart';
import 'package:salon_provider/repositories/all_service_repository.dart';

class ServiceDetailsProvider with ChangeNotifier {
  int selectedIndex = 0;
  String? selectedImage;
  ItemService? itemService;
  List locationList = [];
  var repo = getIt.get<AllServiceRepository>();

  onInit(context) async {
    var arg = ModalRoute.of(context)?.settings.arguments;
    var service = arg as ItemService;
    try {
      var res = await repo.getServiceById(service.id ?? "");
      itemService = res;
    } catch (e) {
      if (e is DioException) {
        Utils.error(e);
      }
    }
    notifyListeners();
  }

  onImageChange(index, value) {
    selectedIndex = index;
    selectedImage = value;

    notifyListeners();
  }

  /*onReady(context){
    final value = Provider.of<SignUpCompanyProvider>(context);

    value.notifyListeners();
   }*/

  onServiceDelete(context, sync) {
    final value = Provider.of<DeleteDialogProvider>(context, listen: false);

    value.onDeleteDialog(sync, context, eImageAssets.service,
        appFonts.deleteService, appFonts.areYouSureDeleteService, () {
      route.pop(context);
      value.onResetPass(
          context,
          language(context, appFonts.hurrayServiceDelete),
          language(context, appFonts.okay),
          () => Navigator.pop(context));

      notifyListeners();
    });
    value.notifyListeners();
  }
}
