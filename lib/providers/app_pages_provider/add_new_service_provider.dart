import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:salon_provider/common/Utils.dart';
import 'package:salon_provider/config.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/model/response/category_response.dart';
import 'package:salon_provider/network/api_config.dart';
import 'package:salon_provider/repositories/add_new_service_repository.dart';
import 'package:path_provider/path_provider.dart';

class AddNewServiceProvider with ChangeNotifier {
  var repo = getIt<AddNewServiceRepository>();

  CategoryItem? categoryValue;
  CategoryItem? subCategoryValue;
  String? durationValue;
  int selectIndex = 0;
  String? taxIndex;
  bool isSwitch = false, isEdit = false;
  String argData = 'NULL';
  String? thumbNailImage;
  String? mainImage;

  TextEditingController serviceName = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController duration = TextEditingController();
  TextEditingController availableService = TextEditingController();
  TextEditingController minRequired = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController discount = TextEditingController();
  TextEditingController tax = TextEditingController();
  TextEditingController featuredPoints = TextEditingController();

  TextEditingController slugController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountedPriceController = TextEditingController();
  TextEditingController durationController = TextEditingController();

  FocusNode serviceNameFocus = FocusNode();
  FocusNode descriptionFocus = FocusNode();
  FocusNode durationFocus = FocusNode();
  FocusNode availableServiceFocus = FocusNode();
  FocusNode minRequiredFocus = FocusNode();
  FocusNode amountFocus = FocusNode();
  FocusNode discountFocus = FocusNode();
  FocusNode taxFocus = FocusNode();
  FocusNode featuredPointsFocus = FocusNode();

  FocusNode slugFocus = FocusNode();
  FocusNode titleFocus = FocusNode();
  FocusNode priceFocus = FocusNode();
  FocusNode discountedPriceFocus = FocusNode();

  XFile? imageFile, thumbFile;
  String? image, thumbImage;

  String? slug = "";

  CategoryResponse? categoryResponse;
  CategoryResponse? subCategoryResponse;

  CategoryItem? categoryItem;

  XFile? imageThumbnail;
  List<MultipartFile> listMultipartServiceImage = [];

  Future<MultipartFile> convertImageToMultiPart(XFile? file) async {
    MultipartFile multipartFile = await MultipartFile.fromFileSync(
      file!.path,
      filename: file.path.split('/').last, // Lấy tên file
    );
    return multipartFile;
  }

  void clearInput() {
    serviceName.clear();
    description.clear();
    duration.clear();
    availableService.clear();
    minRequired.clear();
    amount.clear();
    discount.clear();
    tax.clear();
    featuredPoints.clear();
    notifyListeners();
  }

  void convertToSlug(String text) {
    slug = text.toSlug();
    notifyListeners();
  }

  void changeDuration(int text) {
    duration.text = text.toString();
    notifyListeners();
  }

  Future<void> addService() async {
    try {
      FormData formData = FormData.fromMap({
        "json": json.encode({
          "slug": serviceName.text.toSlug(),
          "service_version": {
            "title": serviceName.text,
            "description": featuredPoints.text,
            "category_id": categoryValue!.id,
            "sub_category_id": subCategoryValue!.id,
            "thumbnail": "",
            "price": amount.text,
            "discounted_price": discount.text,
            "duration": int.parse(durationValue ?? "15") *
                1000, // Convert to milliseconds
            "main_image_id": "0"
          }
        }),
        "images": thumbFile != null
            ? await MultipartFile.fromFile(
                thumbFile!.path,
                filename: thumbFile!.path.split('/').last,
              )
            : null,
      });

      var res = await ApiConfig().dio.post(
            "/service",
            data: formData,
            options: Options(
              contentType: "multipart/form-data",
            ),
          );

      if (res.statusCode == 200) {
        // Handle success
        log("Service added successfully: ${res.data}");
      } else {
        log("Failed to add service: ${res.statusMessage}");
      }
    } catch (e) {
      if (e is DioException) {
        Utils.error(e);
      }
      log("ERROR: $e");
    }
    notifyListeners();
  }

  Future<void> fetchCategory() async {
    try {
      final response = await repo.fetchCategories();
      if (response != null) {
        categoryResponse = response;
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text(response.message!),
        // ));
      }
      notifyListeners();
    } catch (e) {
      log("ERROR: $e");
    }
  }

  Future<void> fetchSubCategory(String id) async {
    try {
      final response = await repo.fetchSubCategories(id);
      if (response != null) {
        subCategoryResponse = response;
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text(response.message!),
        // ));
      }
      notifyListeners();
    } catch (e) {
      log("ERROR: $e");
    }
  }

  onReady(context) {
    log("AGGG argdata $argData");
    dynamic data = ModalRoute.of(context)!.settings.arguments ?? "";
    log("AGGG DATATA $data");

    featuredPointsFocus.addListener(() {
      notifyListeners();
    });

    descriptionFocus.addListener(() {
      notifyListeners();
    });

    if (data != "") {
      isEdit = data["isEdit"] ?? false;
      image = data["image"] ?? "";
      thumbImage = data["thumb_image"] ?? "";
      serviceName.text = data["service_name"] ?? "";
      categoryValue = data["category"] ?? 3;
      subCategoryValue = data["sub_category"] ?? 3;
      description.text = data["description"] ?? "";
      duration.text = data["duration"] ?? "2";
      availableService.text = data["area"] ?? "";
      minRequired.text = data["req_servicemen"] ?? "1";
      amount.text = data["price"] ?? "1";
      taxIndex = data["tax"] ?? 0;
      featuredPoints.text = data["featured_points"] ?? "";
      isSwitch = data["status"] ?? true;

      log("categoryValue ;$categoryValue");
      notifyListeners();
    }
  }

  onBack() {
    isEdit = false;
    image = "";
    thumbImage = "";
    serviceName.text = "";
    categoryValue = null;
    subCategoryValue = null;
    description.text = "";
    duration.text = "";
    availableService.text = "";
    minRequired.text = "";
    amount.text = "";
    taxIndex = null;
    featuredPoints.text = "";
    isSwitch = false;
    notifyListeners();
  }

  onBackButton(context) {
    route.pop(context);
    isEdit = false;
    image = "";
    thumbImage = "";
    serviceName.text = "";
    categoryValue = null;
    subCategoryValue = null;
    description.text = "";
    duration.text = "";
    availableService.text = "";
    minRequired.text = "";
    amount.text = "";
    taxIndex = null;
    featuredPoints.text = "";
    isSwitch = false;

    notifyListeners();
  }

  void updateInformation(information) {
    argData = information;
    notifyListeners();
  }

  onAvailableServiceTap(context) async {
    var result = await route.push(context, LocationListScreen());
    availableService.text = result;
    notifyListeners();
  }

  // GET IMAGE FROM GALLERY
  Future getImage(context, source, isThumbnail) async {
    final ImagePicker picker = ImagePicker();
    if (isThumbnail) {
      route.pop(context);

      thumbFile = (await picker.pickImage(source: source))!;
      final dir = await getTemporaryDirectory();
      String targetPath = '${dir.path}/${thumbFile!.name}.jpg';

      XFile? fileCompressed =
          await Utils.compressAndGetFile(thumbFile!, targetPath);
      MultipartFile fileThumbnail =
          await convertImageToMultiPart(fileCompressed);
      // imageThumbnail = (fileThumbnail)
      imageThumbnail = fileCompressed;
    } else {
      route.pop(context);
      imageFile = (await picker.pickImage(source: source))!;
      final dir =
          await getTemporaryDirectory(); // or getApplicationDocumentsDirectory();
      String targetPath = '${dir.path}/${imageFile!.name}.jpg';
      XFile? fileCompressed =
          await Utils.compressAndGetFile(imageFile!, targetPath);
      MultipartFile fileImageService =
          await convertImageToMultiPart(fileCompressed);
      listMultipartServiceImage.add(fileImageService);
    }
    notifyListeners();
  }

  onImagePick(context, isThumbnail) {
    showLayout(context, onTap: (index) {
      if (index == 0) {
        if (isThumbnail) {
          getImage(context, ImageSource.gallery, isThumbnail);
        } else {
          getImage(context, ImageSource.gallery, isThumbnail)
              .then((value) => appArray.serviceImageList.add(imageFile!.path));
        }
        notifyListeners();
      } else {
        if (isThumbnail) {
          getImage(context, ImageSource.camera, isThumbnail);
        } else {
          getImage(context, ImageSource.camera, isThumbnail)
              .then((value) => appArray.serviceImageList.add(imageFile!.path));
        }
        notifyListeners();
      }
    });
  }

  onRemoveServiceImage(isThumbnail, {index}) {
    if (isThumbnail) {
      thumbFile = null;
      notifyListeners();
    } else {
      appArray.serviceImageList.removeAt(index);
      notifyListeners();
    }
  }

  onTapSwitch(val) {
    isSwitch = val;
    notifyListeners();
  }

  onChangeTax(index) {
    taxIndex = index;
    notifyListeners();
  }

  onChangePrice(index) {
    selectIndex = index;
    notifyListeners();
  }

  onChangeCategory(CategoryItem val) {
    categoryValue = val;
    fetchSubCategory(val.id.toString());
    log("VAL :$categoryValue");
    notifyListeners();
  }

  onChangeSubCategory(val) {
    subCategoryValue = val;

    notifyListeners();
  }

  onChangeDuration(val) {
    durationValue = val.toString();
    notifyListeners();
  }
}
