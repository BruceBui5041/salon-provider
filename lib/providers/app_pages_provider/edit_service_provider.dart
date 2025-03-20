import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fixit_provider/common/Utils.dart';
import 'package:fixit_provider/config.dart';
import 'package:fixit_provider/config/injection_config.dart';
import 'package:fixit_provider/model/response/category_response.dart';
import 'package:fixit_provider/model/response/service_response.dart';
import 'package:fixit_provider/model/response/service_version_response.dart';
import 'package:fixit_provider/network/api_config.dart';
import 'package:fixit_provider/screens/app_pages_screens/add_new_service_screen/repository/add_new_service_repository.dart';
import 'package:fixit_provider/screens/app_pages_screens/edit_service_screen/repository/edit_service_repository.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class EditServiceProvider extends ChangeNotifier {
  var repo = getIt<AddNewServiceRepository>();
  var repoEdit = getIt<EditServiceRepository>();

  CategoryItem? categoryValue;
  CategoryItem? subCategoryValue;
  ServiceVersion? serviceVersionCraft;
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

  bool? showDraft = false;

  XFile? imageFile, thumbFile;
  String? image, thumbImage;

  String? slug = "";

  CategoryResponse? categoryResponse;
  CategoryResponse? subCategoryResponse;

  CategoryItem? categoryItem;

  XFile? imageThumbnail;
  List<MultipartFile> listMultipartServiceImage = [];
  ItemService? itemService;

  void passData(ItemService item, {Function? callback}) {
    itemService = item;
    // if(categoryResponse == null) {
    //  categoryValue = categoryResponse!.data!
    //     .firstWhere((element) => element == itemService!.slug);
    // }

    notifyListeners();
    if (callback != null) {
      callback();
    }
    // Your code here
  }

  void onCraftSelected(ServiceVersion serviceVersion) {
    serviceVersionCraft = serviceVersion;
    notifyListeners();
  }

  void onShowDraft(bool val) {
    showDraft = val;
    notifyListeners();
  }

  void initData() {
    if (itemService != null) {
      serviceName.text = itemService!.serviceVersion!.title!;
      description.text = itemService!.serviceVersion!.description!;
      duration.text = itemService!.serviceVersion!.duration!.toString();
      // availableService.text = itemService!.serviceVersion!.availableService!;
      // minRequired.text = itemService!.serviceVersion!.minRequired!;
      amount.text = itemService!.serviceVersion!.price!;
      // discount.text = itemService!.serviceVersion!.discount!;
      // tax.text = itemService!.serviceVersion!.tax!;
      // featuredPoints.text = itemService!.serviceVersion!.featuredPoints!;
      slugController.text = itemService!.slug!;
      // titleController.text = itemService!.serviceVersion!.name!;
      priceController.text = itemService!.serviceVersion!.price!;
      discountedPriceController.text =
          (itemService!.serviceVersion!.discountedPrice != null)
              ? itemService!.serviceVersion!.discountedPrice!.toString()
              : "";
      durationController.text =
          itemService!.serviceVersion!.duration!.toString();
      print("DURATION: ${itemService!.serviceVersion!.duration}");
    }
  }

  Future<void> publishService({Function? callBack}) async {
    try {
      await repoEdit.publisthService(
          itemService!.id!, itemService!.serviceVersion!.id!);

      if (callBack != null) {
        callBack();
      }
    } catch (e) {
      if (e is DioException) {
        print(e.response!.data);
      }
    }
  }

  Future<void> saveCraft() async {}

  Future<void> createCrat() async {
    await repoEdit.createCraft(itemService!.id!);
  }

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

  Future<void> updateServiceCraft({Function()? callBack}) async {
    var images = listMultipartServiceImage;
    var thumbNail = await MultipartFile.fromFile(
      thumbFile!.path,
      filename: thumbFile!.path.split('/').last,
    );
    var mainImage = await MultipartFile.fromFile(
      imageFile!.path,
      filename: imageFile!.path.split('/').last,
    );

    FormData formData = FormData.fromMap({
      "json": json.encode({
        "slug": slug,
        // "owner_id": "",
        "service_version": {
          "title": titleController.text,
          "description": description.text,
          "category_id": categoryValue!.id,
          "sub_category_id": subCategoryValue!.id,
          "thumbnail": thumbFile!.path, // Chuyển đổi đúng dạng MultipartFile
          "price": priceController.text,
          "discounted_price": discountedPriceController.text,
          "duration": int.parse(durationController.text),
          // "main_image_id": "2", // Chuyển đổi đúng dạng MultipartFile
        }
      }).toString(),
      "images": thumbNail
      // await MultipartFile.fromFile(
      //   imageThumbnail!.path,
      //   filename: imageThumbnail!.path.split('/').last,
      // )
      , // Danh sách file ảnh
    });

    // log(json.encode(jsonBody));
    // FormData formData = FormData.fromMap({
    //   "json": json.encode(jsonBody), // convert json to string
    //   "images": images, // Danh sách file
    // });

    try {
      var res = await ApiConfig().dio.put(
            "/service/${itemService!.id}",
            data: formData,
            options: Options(
              contentType: "multipart/form-data",
            ),
          );
      print(res.data);
    } catch (e) {
      if (e is DioError) {
        print(e.response!.data);
      }
      log("ERROR: $e");
    }
    if (callBack != null) {
      callBack();
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
    durationValue = val;
    notifyListeners();
  }
}
