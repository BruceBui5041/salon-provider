import '../../config.dart';

class CategoriesListProvider with ChangeNotifier{
  TextEditingController searchCtrl = TextEditingController();

  FocusNode searchFocus = FocusNode();
  bool isGrid = true;
  List<CategoryModel> categoryList =[];
  int? selectedIndex;

  onGrid(){
    isGrid = !isGrid;
    notifyListeners();
  }


  onReady(context)async{
    categoryList= [];
    notifyListeners();

    appArray.categoriesList.asMap().entries.forEach((element) {
      if(!categoryList.contains(CategoryModel.fromJson(element.value))) {
        categoryList.add(CategoryModel.fromJson(element.value));
      }
    });
    notifyListeners();
  }

}