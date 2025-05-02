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
  Service? _itemService;
  List<ImageResponse> _imageService = [];
  List<ImageResponse> _imageServiceSelected = [];
  List<ImageResponse> _imageServiceSelectedVersionMultiple = [];
  List<ImageResponse> _imageServiceSelectedVersionSingle = [];
  ImageResponse? _groupValueImage;
  Service? get itemService => _itemService;
  XFile? imageFile;

  List<ImageResponse> get imageService => _imageService;
  List<ImageResponse> get imageServiceSelected => _imageServiceSelected;
  List<ImageResponse> get imageServiceSelectedVersionSingle =>
      _imageServiceSelectedVersionSingle;
  ImageResponse? get groupValueImage => _groupValueImage;
  List<ImageResponse> get imageServiceSelectedVersionMultiple =>
      _imageServiceSelectedVersionMultiple;

  void setImageServiceSelectedVersionMultiple(ImageResponse value) {
    _imageServiceSelectedVersionMultiple.add(value);
    notifyListeners();
  }

  void setImageServiceSelectedVersionSingle(ImageResponse value) {
    _imageServiceSelectedVersionSingle.add(value);
    notifyListeners();
  }

  void removeImageServiceSelectedVersionSingle(ImageResponse value) {
    _imageServiceSelectedVersionSingle
        .removeWhere((element) => element.id == value.id);
    notifyListeners();
  }

  void removeAllImageServiceSelectedVersionMultiple() {
    _imageServiceSelectedVersionMultiple.clear();
    _imageServiceSelectedVersionSingle.clear();
    _imageServiceSelected.clear();
    _groupValueImage = null;
    _imageService.clear();
    _itemService = null;
    notifyListeners();
  }

  void removeImageServiceSelectedVersionMultiple(ImageResponse value) {
    _imageServiceSelectedVersionMultiple
        .removeWhere((element) => element.id == value.id);
    notifyListeners();
  }

  void setGroupValueImage(ImageResponse? value) {
    _groupValueImage = value;
    notifyListeners();
  }

  void setImageService(List<ImageResponse> value) {
    _imageService = value;
    notifyListeners();
  }

  void setImageVersionSelected(List<ImageResponse> value) {
    _imageServiceSelected = value;
    notifyListeners();
  }

  Future<void> fetchServiceById(String id, String serviceVersionId) async {
    _groupValueImage = null;
    _imageServiceSelectedVersionMultiple = [];
    try {
      await repoService.getServiceById(id).then((value) {
        setImageService(value.imageResponse ?? []);
        if (serviceVersionId != null) {
          var serviceVersionSelected = value.versionsResponse
              ?.where((element) => element.id == serviceVersionId)
              .toList();
          if (serviceVersionSelected != null &&
              serviceVersionSelected.isNotEmpty) {
            _imageServiceSelectedVersionMultiple
                .addAll(serviceVersionSelected.first.images ?? []);
            if (serviceVersionSelected.first.mainImageResponse != null) {
              // _groupValueImage = serviceVersionSelected.first.mainImageResponse;
              setGroupValueImage(
                  serviceVersionSelected.first.mainImageResponse);
              _imageServiceSelectedVersionSingle
                  .add(serviceVersionSelected.first.mainImageResponse!);
            }

            setImageVersionSelected(serviceVersionSelected!.first.images ?? []);
          }
        }
        notifyListeners();
      });
    } catch (e) {
      if (e is DioException) {
        Utils.error(e);
      }
    }
    notifyListeners();
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
