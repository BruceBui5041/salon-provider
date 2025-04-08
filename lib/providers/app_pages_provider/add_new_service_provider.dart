import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:salon_provider/common/Utils.dart';
import 'package:salon_provider/config.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/model/response/category_response.dart';
import 'package:salon_provider/model/response/service_response.dart';
import 'package:salon_provider/model/response/service_version_response.dart';
import 'package:salon_provider/network/api_config.dart';
import 'package:salon_provider/repositories/add_new_service_repository.dart';
import 'package:path_provider/path_provider.dart';

class AddNewServiceProvider with ChangeNotifier {
  var repo = getIt<AddNewServiceRepository>();

  CategoryItem? categoryValue;
  CategoryItem? subCategoryValue;
  List<ServiceVersion>? publishDateVersion;
  String? durationValue;
  int selectIndex = 0;
  String? taxIndex;
  bool isSwitch = false, isEdit = false;
  String argData = 'NULL';
  String? thumbNailImage;
  String? mainImage;
  bool? showDraft = false;
  ItemService? itemServiceSelected;
  List<ServiceVersion>? serviceVersionList;
  ServiceVersion? serviceVersionSelected;

  bool? isShowDraft = false;

  //
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
    // var images = listMultipartServiceImage;
    var image = await MultipartFile.fromFile(
      thumbFile!.path,
      filename: thumbFile!.path.split('/').last,
    );
    var mainImage = await MultipartFile.fromFile(
      imageFile!.path,
      filename: imageFile!.path.split('/').last,
    );

    try {
      FormData formData = FormData.fromMap({
        "json": json.encode({
          "slug": serviceName.text.toSlug(),
          "service_version": {
            "title": serviceName.text,
            "description": featuredPoints.text,
            "category_id": categoryValue!.id,
            "sub_category_id": subCategoryValue!.id,
            // "thumbnail": thumbFile!.path,
            "price": amount.text,
            "discounted_price": discount.text,
            "duration": int.parse(durationValue ?? "15") *
                1000, // Convert to milliseconds
            "main_image_id": "0"
          }
        }),
        "images": [image],
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

  Future<void> publishService({Function? callBack}) async {
    try {
      await repo.publisthService(
          itemServiceSelected!.id!, serviceVersionSelected!.id!);

      if (callBack != null) {
        callBack();
      }
    } catch (e) {
      if (e is DioException) {
        print(e.response!.data);
      }
    }
  }

  Future<void> createCraft() async {
    await repo.createCraft(itemServiceSelected!.id!);
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

  onReady(context) async {
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
      var category = categoryResponse?.data
          .where((element) => element.name == data["category"])
          .toList();

      var subCategory = subCategoryResponse?.data
          .where((element) => element.name == data["sub_category"])
          .toList();
      if (category!.isNotEmpty) {
        await fetchSubCategory(category!.first.id.toString());
        subCategory = subCategoryResponse?.data
            .where((element) => element.name == data["sub_category"])
            .toList();
      }
      showDraft = data["showDraft"] ?? false;

      isEdit = data["isEdit"] ?? false;
      image = data["image"] ?? "";
      thumbImage = data["thumb_image"] ?? "";
      serviceName.text = data["service_name"] ?? "";
      categoryValue = category!.isNotEmpty ? category.first : null;
      subCategoryValue = subCategory!.isNotEmpty ? subCategory.first : null;
      description.text = data["description"] ?? "";
      duration.text = (data["duration"] ?? "15").toString();
      availableService.text = data["area"] ?? "";
      minRequired.text = data["req_servicemen"] ?? "1";
      amount.text = (data["price"] ?? "0").toString().toCurrencyVnd();
      taxIndex = data["tax"] ?? 0;
      featuredPoints.text = data["featured_points"] ?? "";
      isSwitch = data["status"] ?? false;
      itemServiceSelected = data["itemServiceSelected"];

      serviceVersionList = data["itemServiceSelected"]?.versionsResponse;
      // serviceVersionSelected = itemServiceSelected?.serviceVersion;
      log("itemServiceSelected ;${itemServiceSelected!.toJson()}");

      notifyListeners();
    }
  }

  onInit(ItemService itemService) async {
    var category = categoryResponse?.data
        .where((element) =>
            element.name == itemService.serviceVersion?.categoryResponse?.name)
        .toList();

    var subCategory = subCategoryResponse?.data
        .where((element) =>
            element.name == itemService.serviceVersion?.categoryResponse?.name)
        .toList();
    if (category!.isNotEmpty) {
      await fetchSubCategory(category!.first.id.toString());
      subCategory = subCategoryResponse?.data
          .where((element) =>
              element.name ==
              itemService.serviceVersion?.categoryResponse?.name)
          .toList();
    }
    showDraft = itemService.serviceVersion?.status == "active" ?? false;

    isEdit = itemService.serviceVersion?.status == "active" ?? false;
    image = itemService.serviceVersion?.mainImageResponse?.url ?? "";
    thumbImage = itemService.serviceVersion?.thumbnail ?? "";
    serviceName.text = itemService.serviceVersion?.title ?? "";
    categoryValue = category!.isNotEmpty ? category.first : null;
    subCategoryValue = subCategory!.isNotEmpty ? subCategory.first : null;
    description.text = itemService.serviceVersion?.description ?? "";
    duration.text = (itemService.serviceVersion?.duration ?? "15").toString();
    // availableService.text = itemService.serviceVersion?.service?.area ?? "";
    // minRequired.text = itemService.serviceVersion?.service?.reqServicemen ?? "1";
    amount.text =
        (itemService.serviceVersion?.price ?? "0").toString().toCurrencyVnd();
    // taxIndex = itemService.serviceVersion?.service?.tax ?? 0;
    // featuredPoints.text = itemService.serviceVersion?.service?.featuredPoints ?? "";
    isSwitch = itemService.serviceVersion?.status == "active" ?? false;
    itemServiceSelected = itemService;
    // serviceVersionSelected = itemService.versionsResponse
    //         ?.where((element) => element.status == "active")
    //         .toList()
    //         .first ??
    //     (itemService.versionsResponse != null &&
    //             itemService.versionsResponse!.isNotEmpty
    //         ? itemService.versionsResponse!.first
    //         : null);
  }

  void onShowDraft(bool val) {
    showDraft = val;
    notifyListeners();
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

  Future<void> onCraftSelected(ServiceVersion serviceVersion) async {
    // serviceVersionSelected = serviceVersion;
    var res = await repo.fetchServiceVersion(serviceVersion.id ?? "");
    log("res ;${res.toJson()}");
    onInit(res.data?.first.service ??
        ItemService(
          // id: 0,
          status: "",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          slug: "",
          ratingCount: null,
          reviewInfo: null,
          avgRating: '', id: '',
        ));
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
    subCategoryValue = null;
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
