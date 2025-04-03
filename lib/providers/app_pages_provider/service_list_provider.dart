import 'package:salon_provider/config.dart';

class ServiceListProvider with ChangeNotifier {
  List<CategoryModel> categoryList = [];
  int selectedIndex = 0;
  TabController? controller;
  int tabIndex = 0;

  onTapTab(val) {
    controller!.index = val;
    notifyListeners();
  }

  onReady(sync) {
    categoryList = [];
    notifyListeners();
    appArray.categoriesList.asMap().entries.forEach((element) {
      if (!categoryList.contains(CategoryModel.fromJson(element.value))) {
        categoryList.add(CategoryModel.fromJson(element.value));
      }
    });
    controller = TabController(
        length: categoryList[selectedIndex].hasSubCategories != null &&
                categoryList[selectedIndex].hasSubCategories!.isNotEmpty
            ? categoryList[selectedIndex].hasSubCategories!.length
            : 0,
        vsync: sync);
    notifyListeners();
  }

  onCategories(index, sync) {
    selectedIndex = index;
    controller = TabController(
        length: categoryList[selectedIndex].hasSubCategories != null &&
                categoryList[selectedIndex].hasSubCategories!.isNotEmpty
            ? categoryList[selectedIndex].hasSubCategories!.length
            : 0,
        vsync: sync);
    notifyListeners();
  }
}
