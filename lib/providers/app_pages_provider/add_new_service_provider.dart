import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:salon_provider/common/Utils.dart';
import 'package:salon_provider/config.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/model/response/category_response.dart';
import 'package:salon_provider/model/response/image_response.dart';
import 'package:salon_provider/model/response/service_response.dart';
import 'package:salon_provider/model/response/service_version_response.dart';
import 'package:salon_provider/network/api_config.dart';
import 'package:salon_provider/repositories/add_new_service_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:salon_provider/repositories/all_service_repository.dart';

class AddNewServiceProvider with ChangeNotifier {
  // Repositories
  final repo = getIt<AddNewServiceRepository>();
  final repoService = getIt<AllServiceRepository>();
  final formKey = GlobalKey<FormState>();

  // Service Data
  CategoryItem? categoryValue;
  CategoryItem? subCategoryValue;
  List<ServiceVersion>? publishDateVersion;
  String? durationValue;
  int selectIndex = 0;
  String? taxIndex;
  bool isSwitch = false;
  bool isEdit = false;
  String argData = 'NULL';
  String? thumbNailImage;
  String? mainImage;
  bool? showDraft = false;
  Service? serviceSelected;
  List<ServiceVersion>? serviceVersionList;
  ServiceVersion? serviceVersionSelected;
  String? mainImageId;
  bool? isDraft = false;
  bool? isLoadingData = false;
  Map<String, dynamic> currentService = {};

  // Draft Service Properties
  String? selectedDraftService;
  List<String> draftServices = [];

  // Text Controllers
  final TextEditingController serviceName = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController duration = TextEditingController();
  final TextEditingController availableService = TextEditingController();
  final TextEditingController minRequired = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final TextEditingController discount = TextEditingController();
  final TextEditingController tax = TextEditingController();
  final TextEditingController featuredPoints = TextEditingController();
  final TextEditingController slugController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountedPriceController =
      TextEditingController();
  final TextEditingController durationController = TextEditingController();

  // Focus Nodes
  final FocusNode serviceNameFocus = FocusNode();
  final FocusNode descriptionFocus = FocusNode();
  final FocusNode durationFocus = FocusNode();
  final FocusNode availableServiceFocus = FocusNode();
  final FocusNode minRequiredFocus = FocusNode();
  final FocusNode amountFocus = FocusNode();
  final FocusNode discountFocus = FocusNode();
  final FocusNode taxFocus = FocusNode();
  final FocusNode featuredPointsFocus = FocusNode();
  final FocusNode slugFocus = FocusNode();
  final FocusNode titleFocus = FocusNode();
  final FocusNode priceFocus = FocusNode();
  final FocusNode discountedPriceFocus = FocusNode();

  //error text
  String? errorServiceName;
  String? errorAmount;
  String? errorDiscount;
  String? errorDuration;
  String? errorCategory;
  String? errorSubCategory;

  // Image Related
  XFile? imageFile;
  XFile? thumbFile;
  String? image;
  String? thumbImage;
  String? slug = "";
  XFile? imageThumbnail;
  List<MultipartFile> listMultipartServiceImage = [];

  // Category Related
  List<CategoryItem>? categoryResponse = [];
  List<CategoryItem>? subCategoryResponse = [];
  CategoryItem? categoryItem;
  List<String> pathMainImageSystem = [];
  String pathMainImageUrl = "";
  List<String> pathImageService = [];
  String? pathMainImageId;

  List<ImageResponse> listAllImage = [];
  List<ImageResponse> listImageServiceSelected = [];
  // Image Handling Methods
  Future<MultipartFile> convertImageToMultiPart(XFile? file) async {
    MultipartFile multipartFile = await MultipartFile.fromFileSync(
      file!.path,
      filename: file.path.split('/').last,
    );
    return multipartFile;
  }

  clearError() {
    errorServiceName = null;
    errorAmount = null;
    errorDiscount = null;
    errorDuration = null;
    errorCategory = null;
    errorSubCategory = null;
    notifyListeners();
  }

  // Input Management Methods
  void clearInput() {
    clearError();
    serviceName.clear();
    description.clear();
    duration.clear();
    availableService.clear();
    minRequired.clear();
    amount.clear();
    discount.clear();
    tax.clear();
    featuredPoints.clear();
    categoryValue = null;
    subCategoryValue = null;
    pathMainImageUrl = "";
    pathMainImageSystem = [];
    pathImageService = [];

    subCategoryResponse = [];
    categoryResponse = [];
    pathMainImageSystem = [];
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

  // Service Management Methods
  Future<void> fetchCurrentService() async {
    isLoadingData = true;
    notifyListeners();
    serviceVersionList = [];
    serviceVersionSelected = null;

    var serviceInit = await repoService.getServiceById(serviceSelected!.id!);
    listAllImage = serviceInit.imageResponse ?? [];
    isLoadingData = false;
    await Future.delayed(const Duration(milliseconds: 500));

    serviceVersionSelected = serviceInit.serviceVersion;
    log("serviceVersionList ${json.encode(serviceVersionList)}");
    onInitService(currentService);
    pathImageService =
        serviceInit.serviceVersion?.images?.map((e) => e.url ?? "").toList() ??
            [];
    notifyListeners();
  }

  onApplyImage(List<ImageResponse> imageSelected,
      {bool isMainImage = false, Function()? callBack}) {
    if (isMainImage) {
      pathMainImageId = imageSelected.first.id;
      pathMainImageUrl = imageSelected.first.url ?? "";
    } else {
      listImageServiceSelected = imageSelected;

      pathImageService = imageSelected.map((e) => e.url ?? "").toList();
    }
    notifyListeners();
    if (callBack != null) {
      callBack();
    }
  }

  bool checkError(BuildContext context) {
    clearError();
    if (serviceName.text.isEmpty) {
      errorServiceName = language(context, appFonts.pleaseEnterName);
    }
    if (amount.text.isEmpty) {
      errorAmount = language(context, appFonts.pleaseEnterNumber);
    }
    if (discount.text.isEmpty) {
      errorDiscount = language(context, appFonts.pleaseEnterNumber);
    }
    if (durationValue == null) {
      errorDuration = language(context, appFonts.pleaseEnterNumber);
    }
    if (categoryValue == null) {
      errorCategory = language(context, "Please select category");
    }
    if (subCategoryValue == null) {
      errorSubCategory = language(context, "Please select sub category");
    }
    notifyListeners();
    if (errorServiceName != null ||
        errorAmount != null ||
        errorDiscount != null ||
        errorDuration != null ||
        errorCategory != null ||
        errorSubCategory != null) {
      return true;
    }
    return false;
  }

  Future<void> addService(BuildContext context, {Function()? callBack}) async {
    if (checkError(context)) {
      return;
    }

    try {
      FormData formData = FormData.fromMap({
        "json": json.encode({
          "slug": serviceName.text.toSlug(),
          "service_version": {
            "title": serviceName.text.trim(),
            "description": featuredPoints.text.trim(),
            "category_id": categoryValue!.id,
            "sub_category_id": subCategoryValue!.id,
            "price": amount.text.trim(),
            "discounted_price": discount.text.trim(),
            "duration": int.tryParse(durationValue ?? "0") ?? 0,
            // "main_image_id": null
          }
        }),
        if (pathMainImageSystem.isNotEmpty)
          "images": pathMainImageSystem
              .map((e) =>
                  MultipartFile.fromFileSync(e, filename: e.split('/').last))
              .toList(),
      });

      var res = await ApiConfig().dio.post(
            "/service",
            data: formData,
            options: Options(
              contentType: "multipart/form-data",
            ),
          );

      if (res.statusCode == 200) {
        log("Service added successfully: ${res.data}");
        if (callBack != null) {
          callBack();
        }
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
      if (callBack != null) {
        callBack();
      }
    } catch (e) {
      if (e is DioException) {
        log(e.response!.data);
      }
    }
  }

  void uploadMainImage(XFile image, {Function()? callBack}) {
    pathMainImageSystem = [image.path];
    notifyListeners();
    if (callBack != null) {
      callBack();
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
        "duration": int.parse(duration.text),
        "main_image_id":
            pathMainImageId?.isEmpty ?? true ? null : pathMainImageId,
        "service_men_ids": [],
        "published_date": null,
        "version_images": listImageServiceSelected
            .map((e) => {"image_id": e.id, "order": 0})
            .toList()
      },
    };

    log(json.encode(jsonBody));
    FormData formData = FormData.fromMap({
      "json": json.encode(jsonBody),
      // if (image != null) "images": [image],
      if (pathMainImageSystem.isNotEmpty)
        "images": pathMainImageSystem
            .map((e) =>
                MultipartFile.fromFileSync(e, filename: e.split('/').last))
            .toList(),
    });

    try {
      await ApiConfig().dio.put(
            "/service/${serviceSelected!.id}",
            data: formData,
            options: Options(
              contentType: "multipart/form-data",
            ),
          );
      // update xong phải clear file hình
      pathMainImageSystem = [];
      if (callBack != null) {
        callBack();
      }
    } catch (e) {
      if (e is DioException) {
        Utils.error(e);
      }
      log("ERROR: $e");
    }
    notifyListeners();
  }

  Future<void> createCraft({Function()? callBack}) async {
    try {
      await repo.createCraft(serviceSelected!.id!);

      if (callBack != null) {
        callBack();
      }
    } catch (e) {
      if (e is DioException) {
        await fetchCurrentService();
        Utils.error(e);
      }
    }
  }

  // Category Management Methods
  Future<void> fetchCategory() async {
    try {
      final response = await repo.fetchCategories();
      categoryResponse = response;
      notifyListeners();
    } catch (e) {
      log("ERROR: $e");
    }
  }

  Future<void> fetchSubCategory(String id, {Function()? callBack}) async {
    try {
      final response = await repo.fetchSubCategories(id);
      subCategoryResponse = response.first.subCategories;
      notifyListeners();
      if (callBack != null) {
        callBack();
      }
    } catch (e) {
      log("ERROR: $e");
    }
  }

  // Initialization Methods
  onReady(context) async {
    clearError();
    isLoadingData = true;
    pathMainImageSystem = [];
    dynamic data = ModalRoute.of(context)!.settings.arguments ?? "";
    if (data != "") {
      currentService = data;
      onInitService(currentService);
    }
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

    serviceVersionList = serviceInit.versionsResponse;
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
        // subCategoryValue = subCategory.isNotEmpty
        //     ? subCategory.first
        //     : subCategoryResponse?.first;
      }

      showDraft = currentServiceTmp["showDraft"] ?? false;
      isEdit = currentServiceTmp["isEdit"] ?? false;
      image = serviceInit.serviceVersion?.mainImageResponse?.url ?? "";
      thumbImage = serviceInit.serviceVersion?.thumbnail ?? "";
      serviceName.text = serviceInit.serviceVersion?.title ?? "";
      categoryValue =
          (category != null && category.isNotEmpty) ? category.first : null;
      subCategoryValue = (subCategory.isNotEmpty)
          ? subCategory.first
          : (subCategoryResponse != null && subCategoryResponse!.isNotEmpty)
              ? subCategoryResponse!.first
              : null;
      featuredPoints.text = serviceInit.serviceVersion?.description ?? "";
      duration.text = (serviceInit.serviceVersion?.duration ?? "15").toString();
      amount.text =
          (serviceInit.serviceVersion?.price ?? "0").toString().toCurrencyVnd();
      featuredPoints.text = serviceInit.serviceVersion?.description ?? "";
      isSwitch = serviceInit.serviceVersion?.status == "active";
      discount.text = (serviceInit.serviceVersion?.discountedPrice ?? "0")
          .toString()
          .toCurrencyVnd();

      serviceVersionSelected = serviceSelected?.serviceVersion;
      isDraft = serviceVersionSelected?.publishedDate == null;

      pathImageService = serviceInit.serviceVersion?.images
              ?.map((e) => e.url ?? "")
              .toList() ??
          [];

      pathMainImageUrl =
          serviceInit.serviceVersion?.mainImageResponse?.url ?? "";

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
      await fetchSubCategory(category.first.id.toString(), callBack: () {
        subCategory = (subCategoryResponse ?? [])
            .where((element) =>
                element.name == serviceVersion.categoryResponse?.name)
            .toList();
        categoryValue = category.first;
        subCategoryValue = subCategory.isNotEmpty
            ? subCategory.first
            : subCategoryResponse?.first;
      });
    }

    showDraft = serviceVersion.status == "active";
    image = serviceVersion.mainImageResponse?.url ?? "";
    thumbImage = serviceVersion.thumbnail ?? "";
    serviceName.text = serviceVersion.title ?? "";
    categoryValue = category.isNotEmpty ? category.first : null;
    // subCategoryValue = subCategoryValue;
    description.text = serviceVersion.description ?? "";
    duration.text = (serviceVersion.duration ?? "15").toString();
    discount.text =
        (serviceVersion.discountedPrice ?? "0").toString().toCurrencyVnd();
    amount.text = (serviceVersion.price ?? "0").toString().toCurrencyVnd();
    featuredPoints.text = serviceVersion.description ?? "";
    isSwitch = serviceVersion.status == "active";
    pathMainImageId = serviceVersion.mainImageResponse?.id ?? "";
    pathMainImageUrl = serviceVersion.mainImageResponse?.url ?? "";
    listImageServiceSelected = serviceVersion.images ?? [];
    notifyListeners();
  }

  // UI Event Handlers
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
    pathMainImageUrl = "";
    pathMainImageSystem = [];
    pathImageService = [];
    listAllImage = [];
    listImageServiceSelected = [];
    serviceVersionList = [];
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
    pathImageService = [];
    var res = await repo.fetchServiceVersion(serviceVersion.id ?? "");
    pathImageService = res.images?.map((e) => e.url ?? "").toList() ?? [];
    if (isDraft! == true) {
      var serviceInit = await repoService.getServiceById(serviceSelected!.id!);
      listAllImage = serviceInit.imageResponse ?? [];
    }
    onInit(res, res.categoryResponse);
    notifyListeners();
  }

  // Image Picker Methods
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
      imageThumbnail = fileCompressed;
    } else {
      route.pop(context);
      imageFile = (await picker.pickImage(source: source))!;
      final dir = await getTemporaryDirectory();
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
              .then((value) => pathMainImageSystem.add(imageFile!.path));
        }
        notifyListeners();
      } else {
        if (isThumbnail) {
          getImage(context, ImageSource.camera, isThumbnail);
        } else {
          getImage(context, ImageSource.camera, isThumbnail)
              .then((value) => pathMainImageSystem.add(imageFile!.path));
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

  // UI State Management Methods
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

  // Draft Service Methods
  void updateSelectedDraftService(String newValue) {
    selectedDraftService = newValue;
    notifyListeners();
  }

  void loadDraftServices() {
    draftServices = ['Draft 1', 'Draft 2', 'Draft 3'];
    notifyListeners();
  }
}
