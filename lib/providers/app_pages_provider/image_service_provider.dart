import 'package:dio/dio.dart';
import 'package:salon_provider/common/Utils.dart';
import 'package:salon_provider/config.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/model/response/image_response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salon_provider/model/response/service_response.dart';
import 'package:salon_provider/repositories/add_new_service_repository.dart';
import 'package:salon_provider/repositories/all_service_repository.dart';

class ImageServiceProvider extends ChangeNotifier {
  final repo = getIt<AddNewServiceRepository>();
  final repoService = getIt<AllServiceRepository>();
  ItemService? _itemService;
  List<ImageResponse> _imageService = [];
  ImageResponse? _groupValueImage;
  ItemService? get itemService => _itemService;
  XFile? imageFile;

  List<ImageResponse> get imageService => _imageService;
  ImageResponse? get groupValueImage => _groupValueImage;

  void setGroupValueImage(ImageResponse? value) {
    _groupValueImage = value;
    notifyListeners();
  }

  void setImageService(List<ImageResponse> value) {
    _imageService = value;
    notifyListeners();
  }

  Future<void> fetchServiceById(String id) async {
    _groupValueImage = null;
    try {
      await repoService.getServiceById(id).then((value) {
        setImageService(value.imageResponse ?? []);
        notifyListeners();
      });
    } catch (e) {
      if (e is DioException) {
        Utils.error(e);
      }
    }
  }

  // GET IMAGE FROM GALLERY
  Future getImage(context, source, {Function(XFile)? onSuccess}) async {
    final ImagePicker picker = ImagePicker();
    route.pop(context);
    imageFile = (await picker.pickImage(source: source))!;
    if (imageFile != null) {
      if (onSuccess != null) {
        onSuccess(imageFile!);
      }
    }
    notifyListeners();
  }

  onImagePick(context, {Function(XFile)? onSuccess}) {
    showLayout(context, onTap: (index) {
      if (index == 0) {
        getImage(context, ImageSource.gallery, onSuccess: onSuccess);
      } else {
        getImage(context, ImageSource.camera, onSuccess: onSuccess);
      }
      notifyListeners();
    });
  }
}
