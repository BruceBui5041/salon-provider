import 'package:dio/dio.dart';
import 'package:salon_provider/common/Utils.dart';
import 'package:salon_provider/config.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/model/response/service_response.dart';
import 'package:salon_provider/model/response/service_version_response.dart';
import 'package:salon_provider/repositories/add_new_service_repository.dart';
import 'package:salon_provider/repositories/all_service_repository.dart';

class ServiceDetailsProvider with ChangeNotifier {
  int selectedIndex = 0;
  String? selectedImage;
  Service? itemService;
  ServiceVersion? serviceVersionSelected;
  List<ServiceVersion>? serviceVersionList;
  List locationList = [];
  var repo = getIt.get<AllServiceRepository>();
  var serviceVersionRepo = getIt.get<AddNewServiceRepository>();

  onInit(context) async {
    var arg = ModalRoute.of(context)?.settings.arguments;
    var service = arg as Service;
    try {
      var res = await repo.getServiceById(service.id ?? "");
      itemService = res;
      serviceVersionSelected = res.serviceVersion;
      serviceVersionList = res.versionsResponse;
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

  onVersionSelected(ServiceVersion version) async {
    try {
      // Fetch the detailed version data
      var detailedVersion =
          await serviceVersionRepo.fetchServiceVersion(version.id ?? "");
      serviceVersionSelected = detailedVersion;

      // Update the UI with the selected version data
      if (itemService != null) {
        itemService = itemService!.copyWith(
          serviceVersion: detailedVersion,
        );
      }

      notifyListeners();
    } catch (e) {
      if (e is DioException) {
        Utils.error(e);
      }
    }
  }

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
