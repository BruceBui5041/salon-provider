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
import 'package:salon_provider/repositories/all_service_repository.dart';

class AddNewServiceProvider with ChangeNotifier {
  var repo = getIt<AddNewServiceRepository>();
  var repoService = getIt<AllServiceRepository>();
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
  ItemService? serviceSelected;
  List<ServiceVersion>? serviceVersionList;
  ServiceVersion? serviceVersionSelected;
  String? mainImageId;
  bool? isDraft = false;
  bool? isLoadingData = false;
  Map<String, dynamic> currentService = {};

  // Add properties for draft service dropdown
  String? selectedDraftService;
  List<String> draftServices = [];

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

  List<CategoryItem>? categoryResponse = [];

  List<CategoryItem>? subCategoryResponse;

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

  Future<void> fetchCurrentService() async {
    await Future.delayed(const Duration(milliseconds: 500));

    var serviceInit = await repoService.getServiceById(serviceSelected!.id!);
    serviceVersionList = serviceInit.versionsResponse;
    serviceVersionSelected = serviceInit.serviceVersion;
    log("serviceVersionList ${json.encode(serviceVersionList)}");
    onInitService(currentService);

    notifyListeners();
  }

  Future<void> addService() async {
    // var images = listMultipartServiceImage;
    MultipartFile? image;
    if (thumbFile != null) {
      image = await MultipartFile.fromFile(
        thumbFile!.path,
        filename: thumbFile!.path.split('/').last,
      );
    }

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
            "duration": int.parse(duration.text), // Convert to milliseconds
            "main_image_id": "0"
          }
        }),
        "images": image != null ? [image] : [],
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
          serviceSelected!.id!, serviceVersionSelected!.id!);
      await repo.fetchServiceVersion(serviceVersionSelected!.id!);
      // onInit(res, res.categoryResponse!);
      if (callBack != null) {
        callBack();
      }
    } catch (e) {
      if (e is DioException) {
        print(e.response!.data);
      }
    }
  }

  Future<void> updateServiceCraft({Function()? callBack}) async {
    MultipartFile? image;
    if (thumbFile != null) {
      image = await MultipartFile.fromFile(
        thumbFile!.path,
        filename: thumbFile!.path.split('/').last,
      );
    }
    String priceText = amount.text
        .replaceAll(".", "")
        .replaceAll(",", "")
        .replaceAll("đ", "")
        .replaceAll(" ", "");
    String discountText = discount.text
        .replaceAll(".", "")
        .replaceAll(",", "")
        .replaceAll("đ", "")
        .replaceAll(" ", "");
    Map<String, dynamic> jsonBody = {
      "id": serviceSelected!.id,
      "slug": serviceName.text.toSlug(),
      "service_version": {
        "id": serviceVersionSelected!.id,
        "status": isSwitch ? "active" : "inactive",
        "title": serviceName.text,
        "description": featuredPoints.text,
        "category_id": categoryValue?.id,
        "sub_category_id": subCategoryValue?.id,
        "thumbnail": null,
        "price": int.parse(priceText),
        "discounted_price": int.parse(discountText),
        "duration": int.parse(duration.text), // Convert to milliseconds
        "main_image_id": null,
        "service_men_ids": [],
        "published_date": null,
        "version_images": []
      },
      // "images": image != null ? [image] : null,
    };
    // Map<String, dynamic> jsonBody = {
    //   "id": "3zMaaX26T3NwrU",
    //   "slug": "dich-vu-trang-diem",
    //   "service_version": {
    //     "id": "DCZmkENgyLwGgWG",
    //     "status": "inactive",
    //     "title": "dich vu Trang diem",
    //     "description": "What ever",
    //     "category_id": "3w5rMLKLTUiANS",
    //     "sub_category_id": "3srLErYxdoMerk",
    //     "main_image_id": "3mKb6RrXJbHcTi",
    //     "thumbnail":
    //         "https://d3i048dqjftjb3.cloudfront.net/https://d3i048dqjftjb3.cloudfront.net/https://d3i048dqjftjb3.cloudfront.net/https://d3i048dqjftjb3.cloudfront.net/https://d3i048dqjftjb3.cloudfront.net/https://d3i048dqjftjb3.cloudfront.net/https://d3i048dqjftjb3.cloudfront.net/https://d3i048dqjftjb3.cloudfront.net/https://d3i048dqjftjb3.cloudfront.net/https://d3i048dqjftjb3.cloudfront.net/https://d3i048dqjftjb3.cloudfront.net//Users/devkhoa/Library/Developer/CoreSimulator/Devices/E8359957-5801-4779-B34D-D1EDB74E37F6/data/Containers/Data/Application/7ABEA53C-A3CB-47B7-BFC6-C5D6E137CFE0/tmp/image_picker_B9DFD3AD-A9B8-48F2-9212-23106F73801E-28858-000003AF3DFC1DE0.jpg",
    //     "price": "102000",
    //     "discounted_price": null,
    //     "duration": 15,
    //     "service_men_ids": [],
    //     "published_date": null,
    //     "version_images": []
    //   }
    // };
    log(json.encode(jsonBody));
    FormData formData = FormData.fromMap({
      "json": json.encode(jsonBody),
      if (image != null) "images": [image],
    });

    try {
      var res = await ApiConfig().dio.put(
            "/service/${serviceSelected!.id}",
            data: formData,
            options: Options(
              contentType: "multipart/form-data",
            ),
          );
      print(res.data);
      if (callBack != null) {
        callBack();
      }
    } catch (e) {
      if (e is DioException) {
        Utils.error(e);
      }
      log("ERROR: $e");
    }
    // if (callBack != null) {
    //   callBack();
    // }
    notifyListeners();
  }

  Future<void> createCraft({Function()? callBack}) async {
    await repo.createCraft(serviceSelected!.id!);
    if (callBack != null) {
      callBack();
    }
  }

  Future<void> fetchCategory() async {
    try {
      final response = await repo.fetchCategories();
      categoryResponse = response;
      notifyListeners();
    } catch (e) {
      log("ERROR: $e");
    }
  }

  Future<void> fetchSubCategory(String id) async {
    try {
      final response = await repo.fetchSubCategories(id);
      subCategoryResponse = response.first.subCategories;
      notifyListeners();
    } catch (e) {
      log("ERROR: $e");
    }
  }

  onReady(context) async {
    isLoadingData = true;
    dynamic data = ModalRoute.of(context)!.settings.arguments ?? "";
    currentService = data;
    onInitService(currentService);
    isLoadingData = false;

    notifyListeners();
  }

  onInitService(Map<String, dynamic> currentServiceTmp) async {
    featuredPointsFocus.addListener(() {
      notifyListeners();
    });

    descriptionFocus.addListener(() {
      notifyListeners();
    });
    serviceSelected = currentService["itemServiceSelected"];
    var serviceInit = await repoService.getServiceById(serviceSelected!.id!);
    if (currentServiceTmp != "") {
      var category = categoryResponse
          ?.where((element) => element.name == currentServiceTmp["category"])
          .toList();

      var subCategory = (subCategoryResponse ?? [])
          .where((element) => element.name == currentServiceTmp["sub_category"])
          .toList();
      if (category != null && category.isNotEmpty) {
        await fetchSubCategory(category.first.id.toString());
        subCategory = (subCategoryResponse ?? [])
            .where(
                (element) => element.name == currentServiceTmp["sub_category"])
            .toList();
      }
      showDraft = currentServiceTmp["showDraft"] ?? false;

      isEdit = currentServiceTmp["isEdit"] ?? false;
      image = serviceInit.serviceVersion?.mainImageResponse?.url ?? "";
      thumbImage = serviceInit.serviceVersion?.thumbnail ?? "";
      serviceName.text = serviceInit.serviceVersion?.title ?? "";
      categoryValue =
          (category != null && category.isNotEmpty) ? category.first : null;
      subCategoryValue = (subCategory.isNotEmpty) ? subCategory.first : null;

      featuredPoints.text = serviceInit.serviceVersion?.description ?? "";
      duration.text = (serviceInit.serviceVersion?.duration ?? "15").toString();

      amount.text =
          (serviceInit.serviceVersion?.price ?? "0").toString().toCurrencyVnd();
      featuredPoints.text = serviceInit.serviceVersion?.description ?? "";
      isSwitch = serviceInit.serviceVersion?.status == "active";

      discount.text = (serviceInit.serviceVersion?.discountedPrice ?? "0")
          .toString()
          .toCurrencyVnd();

      serviceVersionList =
          currentServiceTmp["itemServiceSelected"]?.versionsResponse;
      serviceVersionSelected = serviceSelected?.serviceVersion;
      isDraft = serviceVersionSelected?.publishedDate == null;
      await Future.delayed(const Duration(milliseconds: 500));
    }
    notifyListeners();
  }

  onInit(ServiceVersion serviceVersion, CategoryItem? categoryItem) async {
    var category = categoryResponse!
        .where((element) => element.name == categoryItem?.name)
        .toList();

    var subCategory = (subCategoryResponse ?? [])
        .where(
            (element) => element.name == serviceVersion.categoryResponse?.name)
        .toList();
    if (category.isNotEmpty) {
      await fetchSubCategory(category.first.id.toString());
      subCategory = (subCategoryResponse ?? [])
          .where((element) =>
              element.name == serviceVersion.categoryResponse?.name)
          .toList();
      categoryValue = category.first;
      subCategoryValue = subCategory.isNotEmpty ? subCategory.first : null;
    }
    showDraft = serviceVersion.status == "active";

    image = serviceVersion.mainImageResponse?.url ?? "";
    thumbImage = serviceVersion.thumbnail ?? "";
    serviceName.text = serviceVersion.title ?? "";
    categoryValue = category.isNotEmpty ? category.first : null;
    subCategoryValue = subCategoryValue;
    description.text = serviceVersion.description ?? "";
    duration.text = (serviceVersion.duration ?? "15").toString();
    discount.text =
        (serviceVersion.discountedPrice ?? "0").toString().toCurrencyVnd();

    amount.text = (serviceVersion.price ?? "0").toString().toCurrencyVnd();
    featuredPoints.text = serviceVersion.description ?? "";
    isSwitch = serviceVersion.status == "active";
    notifyListeners();
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

  void setIsDraft(bool val) {
    isDraft = val;
    notifyListeners();
  }

  Future<void> onDraftSelected(ServiceVersion serviceVersion) async {
    serviceVersionSelected = serviceVersion;
    var res = await repo.fetchServiceVersion(serviceVersion.id ?? "");

    onInit(res, res.categoryResponse);

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
    durationValue = val;
    notifyListeners();
  }

  void updateSelectedDraftService(String newValue) {
    selectedDraftService = newValue;
    notifyListeners();
  }

  void loadDraftServices() {
    // TODO: Load draft services from API or local storage
    draftServices = ['Draft 1', 'Draft 2', 'Draft 3']; // Example data
    notifyListeners();
  }
}
